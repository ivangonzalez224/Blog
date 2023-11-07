require 'rails_helper'
require 'capybara/rails'

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
    Post.create(title: 'Post Title 1', text: 'Post Text 1', user: user)
    Post.create(title: 'Post Title 2', text: 'Post Text 2', user: user)

    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Number of posts: 2')
  end

  it 'displays a post title' do
    Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Post Title')
  end

  it 'displays some of the post body' do
    Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Post Text')
  end

  it 'displays the first comments on a post' do
    post = Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Comment.create(text: 'Comment Text 1', post: post, user: user)
    Comment.create(text: 'Comment Text 2', post: post, user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Comment Text 2')
    expect(page).to have_content('Comment Text 1')
  end

  it 'displays how many comments a post has' do
    post = Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Comment.create(text: 'Comment Text 1', post: post, user: user)
    Comment.create(text: 'Comment Text 2', post: post, user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Comments: 2')
  end

  it 'displays how many likes a post has' do
    post = Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Like.create(post: post, user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_content('Likes: 1')
  end

  it 'displays a button for pagination to see more posts' do
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page

    expect(page).to have_selector('button', text: 'Pagination')
  end

  it 'redirects to the post show page when a post is clicked' do
    post = Post.create(title: 'Post Title', text: 'Post Text', user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_posts_path(user)
    page = Capybara.page
    @post_link = page.find_link('Post Title')
    @user_post_path = Rails.application.routes.url_helpers.user_post_path(user, post)
    @post_link.click
    current_path = Capybara.current_path

    expect(current_path).to eq(@user_post_path)
  end
end
