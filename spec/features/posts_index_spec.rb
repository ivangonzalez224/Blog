require 'rails_helper'

RSpec.describe 'User Posts Index Page', type: feature do
  let(:user) { User.create(name: 'Username1', bio: 'User Bio', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg') }
  
  it 'displays the correct user profile picture' do
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page
    
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it 'displays the correct user name and profile image' do
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page
    
    expect(page).to have_content('Username1')
  end

  it 'displays the number of posts the user has written' do
    post1 = Post.create(title: 'Post Title 1', text: 'Post Text 1', user: user)
    post2 = Post.create(title: 'Post Title 2', text: 'Post Text 2', user: user)

    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Number of posts: 2')
  end

  it 'displays a post title' do
    post= Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Post Title')
  end

  it 'displays some of the post body' do
    post= Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Post Text')
  end
end