require 'rails_helper'

RSpec.describe 'UsersControllers', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #index' do
    it 'returns a successful response for index action' do
      get users_path
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response for the show action' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      get user_path(user)
      expect(response).to be_successful
    end
  end
end
