class CommentsController < ApplicationController
  before_action :find_user_post
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'The Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    if @comment.destroy
      flash[:notice] = 'Comment deleted!'
    else
      flash[:alert] = 'The comment could not be deleted!'
    end
    redirect_to user_post_path(@user, @post)
  end

  private

  def find_user_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
