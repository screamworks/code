class PostsController < ApplicationController

before_filter :authenticate_user!

def new 
	@post = Post.new
end

def create
	@post = current_user.post.create(posts_params)
	if @post.save
	flash[:alert] = "you have created a post"
	redirect_to root_path
	else
	flash[:alert] = "Error, didn't save anything try again"
	redirect_to root_path
	render 'new'
	end
end

def edit
	@post = Post.find(params[:id])

	unless @post.user == current_user
		redirect_to root_path
	end 
end

def update
	@post = Post.find(params[:id])
	unless @post.user == current_user
		redirect_to root_path

	 if @post.update_attributes(post_params)
	 	redirect_to root_path
	 	flash[:notice] = "you have edited your post"
	 else 
	 	render 'edit'
	 	flash[:alert] = "something went wrong"
	 end
end


def destroy
	@post = Post.find(params[:id])
	@post.destroy
	redirect_to root_path
end 

private 
def post_params
	params.require(:post).permit(:content)
end

end

