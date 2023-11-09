class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, :likes)
  end

  def show
    @user = User.includes(:posts).find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(@user)
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.likes.destroy_all
    @post.comments.destroy_all
    @post.destroy
    if @post.destroy
      flash[:notice] = 'Post deleted !'
      redirect_to user_posts_path(@user)
    else
      flash[:alert] = 'The post could not be deleted !'
      redirect_to user_post_path(@user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
