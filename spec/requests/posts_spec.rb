require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  describe 'GET #index' do
    let(:user) { User.create(name: 'Tim', photo: 'Test photo', bio: 'Test bio') }

    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
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
  end
end
