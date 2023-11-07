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

  it 'displays the number of comments the post has' do
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    page = Capybara.page
    expect(page).to have_content('Comments: 0')
    Comment.create(text: 'This is a comment for testing', post: post, user: user)
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    expect(page).to have_content('Comments: 1')
  end
  
  it 'displays the number of likes the post has' do
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    page = Capybara.page
    like_counter = page.find('.postUser-comments span:contains("Likes:")')
    expect(like_counter).to have_content('Likes: 0')
    # Simulate user interaction by dispatching a like to the post
    like_counter.click
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    like_count = post.likes.count
    expect(like_counter).to have_content("Likes: #{like_count}")
  end

  it 'displays the post body' do
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    page = Capybara.page
    expect(page).to have_content('Post Text for testing')
  end

  it 'displays the username of each commentor' do
    second_user = User.create(name: 'Mike', bio: 'Software developer',
                              photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')
    Comment.create(text: 'Comment Text for testing', post: post, user: second_user)
    Capybara.visit Rails.application.routes.url_helpers.user_post_path(user, post)
    page = Capybara.page
    expect(page).to have_content('Mike')
  end

  
end