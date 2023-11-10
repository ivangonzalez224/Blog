class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }
  before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    @post = Post.find(params[:post_id])
    @user = logged_in_user
    @new_user_comment = @post.comments.new(comment_params.merge(user_id: @user.id))
    if @new_user_comment.save
      render json: { success: 'Comment succesfully added!' }
    else
      render json: { error: @new_user_comment.errors.full_messages.join(', ') }
    end
  end

  private

  def comment_params
    params.permit(:text)
  end
end
