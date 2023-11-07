require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'User Post Show Page', type: feature do
  let(:user) { User.create(name: 'Sam', bio: 'User Bio', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg') }
  let(:post) { Post.create(title: 'Post Title for testing', text: 'Post Text for testing', user: user) }

  it 'displays the post title' do
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    page = Capybara.page
    expect(page).to have_content('Post Title for testing')
  end

  it 'displays the name of the user who wrote the post' do
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    page = Capybara.page
    expect(page).to have_content('Sam')
  end

end