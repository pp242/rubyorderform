class PostController < Sinatra::Base
	configure :development do
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new { File.join(root,'views')}

	

	$posts = [{
			title: "1"
	      	body: "Big Mac - 2\nFries - 2\nMilkshake - 4\n Happy meal - 2"
	    },
	    {   
	    	title: "2"  
	      	body: "Wrap of the Day Meal - 2"
	    },
	    {
	    	title: "3"
	      	body: "Happy Meal - 2"
	    }]






	get "/posts" do  		###index
		@posts = $posts
		@page_header = "All the Orders"
		erb :"posts/index"
	end	

	get "/posts/new" do 			### new
		erb :"posts/new"
	end	

	post "/posts" do 			### create
		new_post = {
			title: params[:title],
			body: params[:body]
		}
		$posts << new_post
		redirect '/posts'
		
	end


	get "/posts/:id" do 		### show
		id = (params[:id].to_i)+1
		@posts = $posts[id-1]
		@page_header = "Post #{id}"
		erb :"posts/show"
	end	

	get "/posts/:id/edit" do 		#### edit
		@id = params[:id].to_i
		@post = $posts[@id]
		erb :"posts/edit"
	end
	
	put "/posts/:id" do 			### update
		id = params[:id].to_i
		$posts[id][:title] = params[:title]
		$posts[id][:body] = params[:body]
		redirect '/posts/#{id}'
		
	end

	delete "/posts/:id" do
		id = params[:id].to_i
		$posts.delete_at(id)
		redirect '/posts'
	end

end	