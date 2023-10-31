require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  describe 'GET #index' do
    let(:user) { User.create(name: 'Tim', photo: 'Test photo', bio: 'Test bio') }
    let(:post) { Post.create(user: user, title: 'Post for testing') }
    it 'returns a successful response' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
    end

    it 'returns an error response for a wrong path' do
      get "/users/#{user.id}/failed_path"
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET #index' do
    let(:user) { User.create(name: 'Tim', photo: 'Test photo', bio: 'Test bio') }
    let(:post) { Post.create(user: user, title: 'Post for testing') }

    it 'returns a successful status response' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
    end

    it 'renders the correct view' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Here is a list of posts for a given user')
    end

    it 'does not include the placeholder correctly in the response body for a all post for a given user' do
      get "/users/#{user.id}/posts"
      expect(response.body).not_to include('Not included test placeholder')
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'Joe', photo: 'Test photo', bio: 'Test bio') }
    let(:post) { Post.create(user: user, title: 'Post for testing') }
    it 'returns a successful response for the show action' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'returns an error response for a wrong path' do
      get "/users/#{user.id}/posts/failed_path"
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'Jim', photo: 'Test photo', bio: 'Test bio') }
    let(:post) { Post.create(user: user, title: 'Post for testing') }
    it 'renders the correct view' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Here are the details for a specific post')
    end

    it 'does not include the placeholder correctly in the response body for a specific post' do
      get "/users/#{user.id}/#{post.id}"
      expect(response.body).not_to include('Not included test placeholder')
    end
  end
end
