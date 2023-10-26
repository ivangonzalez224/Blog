require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title, with comments_counter and likes_counter greater than or equal to zero' do
    user = User.create(name: 'Sam', posts_counter: 0)
    post = Post.new(user: user, title: 'Post for testing', comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end
  
  it 'is invalid without a title' do
    user = User.create(name: 'Sam', posts_counter: 0)
    post = Post.new(user: user, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a long title (> 250)' do
    user = User.create(name: 'Sam', posts_counter: 0)
    post = Post.new(user: user, title: 'a' * 255, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end
   
end