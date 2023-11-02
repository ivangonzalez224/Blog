class LikesController < ApplicationController
  before_action :find_post_to_like

  def create
    @like = Like.new(user: current_user, post: @post)

    if @like.save
      flash.now[:notice] = 'You liked the post !'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:alert] = 'Was not possible to like the post !'
    end
  end

  private

  def find_post_to_like
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
