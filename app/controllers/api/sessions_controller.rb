class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }
  skip_before_action :authenticate_user!, only: [:create]
  def create
    @user = User.find_by(email: session_params[:email])
    if @user&.valid_password?(session_params[:password])
      token = generate_token(@user)
      @user.update(api_token: token)
      render json: { api_token: token, message: 'Login successful' }
    else
      render json: { error: 'You entered an invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_token(logged_in_user)
    payload = { user_id: logged_in_user.id, exp: 2.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def session_params
    params.permit(:email, :password)
  end
end
