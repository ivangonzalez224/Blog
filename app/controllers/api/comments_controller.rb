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

  def logged_in_user
    user_id = decoded_token['user_id']
    User.find_by(id: user_id)
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end

  def authenticate_user!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless logged_in_user
  end

  def decoded_token
    token = request.headers['Authorization'].to_s.split.last
    JWT.decode(token, Rails.application.secret_key_base)[0]
  end

  private

  def comment_params
    params.permit(:text)
  end
end
