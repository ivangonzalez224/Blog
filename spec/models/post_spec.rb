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

  it 'is invalid with a comments_counter less than zero' do
    user = User.create(name: 'Tom', posts_counter: 0)
    post = Post.new(user: user, title: 'Test Post', comments_counter: -1, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a non-integer comments_counter' do
    user = User.create(name: 'Tom', posts_counter: 0)
    post = Post.new(user: user, title: 'Post for testing', comments_counter: 2.5, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a likes_counter less than zero' do
    user = User.create(name: 'Tom', posts_counter: 0)
    post = Post.new(user: user, title: 'Post for testing', comments_counter: 0, likes_counter: -1)
    expect(post).to_not be_valid
  end

  it 'is invalid with a non-integer likes_counter' do
    user = User.create(name: 'Tom', posts_counter: 0)
    post = Post.new(user: user, title: 'Post for testing', comments_counter: 0, likes_counter: 1.5)
    expect(post).to_not be_valid
  end

  describe '#update_user_post_counter' do
    it 'increments the user posts_counter when a post is saved' do
      user = User.create(name: 'Ted', posts_counter: 0)
      post = Post.new(user: user, title: 'Test Post', comments_counter: 0, likes_counter: 0)

      expect do
        post.save
        user.reload
      end.to change(user, :posts_counter).by(1)
    end
  end

  describe '#five_most_recent_comments' do
    it 'returns the five most recent comments' do
      user = User.create(name: 'Joe')
      post = Post.create(user: user, title: 'Post for testing', text: 'Test content')

      # Create 5 comments for the user
      comment1 = Comment.create(text: 'Comment1 for testing', post: post, user: user)
      comment2 = Comment.create(text: 'Comment2 for testing', post: post, user: user)
      comment3 = Comment.create(text: 'Comment3 for testing', post: post, user: user)
      comment4 = Comment.create(text: 'Comment4 for testing', post: post, user: user)
      comment5 = Comment.create(text: 'Comment5 for testing', post: post, user: user)
      most_recent_comments = post.five_most_recent_comments

      expect(most_recent_comments).to eq([comment5, comment4, comment3, comment2, comment1])
    end
  end
end
