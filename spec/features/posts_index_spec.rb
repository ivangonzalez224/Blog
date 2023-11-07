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
end