require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'name should be present' do
    expect(subject).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    expect(user).to_not be_valid
  end

  it 'is invalid with a negative posts_counter' do
    user = User.new(name: 'Jim', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'is invalid with a non-integer posts_counter' do
    user = User.new(name: 'Jim', posts_counter: 2.1)
    expect(user).to_not be_valid
  end

  describe '#most_recent_posts' do
    it 'returns the most recent posts' do
      user = User.create(name: 'Mary', posts_counter: 0)

      # Create 4 posts for the user
      Post.create(user: user, title: 'Post 1', text: 'Content 1', created_at: 4.days.ago)
      post2 = Post.create(user: user, title: 'Post 2', text: 'Content 2', created_at: 3.days.ago)
      post3 = Post.create(user: user, title: 'Post 3', text: 'Content 3', created_at: 2.days.ago)
      post4 = Post.create(user: user, title: 'Post 4', text: 'Content 4', created_at: 1.day.ago)

      # Call the three_most_recent_post method
      most_recent_posts = user.three_most_recent_post

      # Expect the method to return the most recent posts (limited to 3)
      expect(most_recent_posts).to eq([post4, post3, post2])
    end
  end
end
