require 'rails_helper'

RSpec.describe 'Users Index', type: :feature do
  it 'displays the user name, profile picture, and post count' do
    User.create(name: 'User test 1',
                photo: 'https://i.blogs.es/d4590b/screenshot_113/1366_2000.jpeg', bio: 'User Bio')
    visit users_path

    expect(page).to have_content('User test 1')
    expect(page).to have_selector('img.user-photo[alt="User photo"]')
    expect(page).to have_content('Number of posts: 0')
  end
end
