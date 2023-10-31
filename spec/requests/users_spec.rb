require 'rails_helper'

RSpec.describe 'UsersControllers', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users' do
    it 'returns a error response' do
      get '/failed_path'
      expect(response).to have_http_status(404)
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

  describe 'GET /users' do
    it 'includes the correct placeholder in the response body' do
      get '/users'
      expect(response.body).to include('Here is a list of all users')
    end
  end

  describe 'GET /users/:id' do
    let(:user) { User.create(name: 'Sam', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer from Peru.') }

    it 'returns a successful response for a specific user' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
    end

    it 'includes the placeholder correctly in the response body for a specific user' do
      get "/users/#{user.id}"
      expect(response.body).to include('This is the user profile')
    end

    it 'does not include the placeholder correctly in the response body for a specific user' do
      get "/users/#{user.id}"
      expect(response.body).not_to include('Not included test placeholder')
    end
  end
end
