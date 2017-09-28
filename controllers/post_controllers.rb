class PostController < Sinatra::Base
	configure :development do
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new { File.join(root,'views')}

	

	$orders = [{
			title: "Jenny",
	      	body: "Big Mac - 2\nFries - 2\nMilkshake - 4\n Happy meal - 2"
	    },
	    {   
	    	title: "Niall" , 
	      	body: "Wrap of the Day Meal - 2"
	    },
	    {
	    	title: "Lucy",
	      	body: "Happy Meal - 2"
	    }]






	get "/orders" do  		###index
		@orders = $orders
		@page_header = "All the Orders"
		erb :"posts/index"
	end	

	get "/orders/new" do 			### new
		erb :"posts/new"
	end	

	post "/orders" do 			### create
		new_order = {
			title: params[:title],
			body: params[:body]
		}
		$orders << new_order
		redirect '/orders'
		
	end


	get "/orders/:id" do 		### show
		id = (params[:id].to_i)+1
		@orders = $orders[id-1]
		@page_header = "Order #{id}"
		erb :"posts/show"
	end	

	get "/orders/:id/edit" do 		#### edit
		@id = params[:id].to_i
		@order = $orders[@id]
		erb :"posts/edit"
	end
	
	put "/orders/:id" do 			### update
		id = params[:id].to_i
		$orders[id][:title] = params[:title]
		$orders[id][:body] = params[:body]
		redirect '/orders'
		
	end

	delete "/orders/:id" do
		id = params[:id].to_i
		$orders.delete_at(id)
		redirect '/orders'
	end

end	