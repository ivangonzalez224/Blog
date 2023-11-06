require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  it 'displays the correct user profile image' do
    user = User.create(name: 'Tom', bio: 'Gamer', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')

    visit user_path(user)
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it 'displays the correct number of user posts' do
    user = User.create(name: 'Jim', bio: 'Student', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')
    Post.create(title: 'Post title for testing', text: 'Post Text for testing', user: user)

    visit user_path(user)

    expect(page).to have_content('Number of posts: 1')
  end
end
