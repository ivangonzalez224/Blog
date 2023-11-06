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

  it 'displays the username' do
    user = User.create(name: 'Jim', bio: 'Student', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')
    Post.create(title: 'Post title for testing', text: 'Post Text for testing', user: user)

    visit user_path(user)

    expect(page).to have_content('Jim')
  end

  it 'displays the correct username' do
    user = User.create(name: 'Jim', bio: 'Student', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')
    Post.create(title: 'Post title for testing', text: 'Post Text for testing', user: user)

    visit user_path(user)
    expect(page).not_to have_content('incorrect name')
  end

  it 'displays the correct user bio' do
    user = User.create(name: 'Jim', bio: 'Student', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')
    Post.create(title: 'Post title for testing', text: 'Post Text for testing', user: user)

    visit user_path(user)
    expect(page).to have_content('Student')
  end

  it 'displays the three most recent user posts' do
    user = User.create(name: 'Kobe', bio: 'Basketball player', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')
    post1 = Post.create(title: 'Post Title 1', text: 'Post Text 1', user: user)
    post2 = Post.create(title: 'Post Title 2', text: 'Post Text 2', user: user)
    post3 = Post.create(title: 'Post Title 3', text: 'Post Text 3', user: user)

    visit user_path(user)

    expect(page).to have_content(post3.title)
    expect(page).to have_content(post2.text)
    expect(page).to have_content(post1.title)
  end

  it 'displays the "See all posts" button' do
    user = User.create(name: 'Jim', bio: 'Student', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')

    visit user_path(user)

    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  it 'redirects to the see all users posts page' do
    user = user = User.create(name: 'Ben', bio: 'Actor', photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg')

    visit user_path(user)

    click_link('See all posts')

    expect(current_path).to eq(user_posts_path(user))
  end
end
