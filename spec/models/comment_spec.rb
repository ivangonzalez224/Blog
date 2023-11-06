require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with content and a post_id' do
    user = User.create(name: 'Jim', posts_counter: 0)
    post = Post.create(user: user, title: 'Post for testing', comments_counter: 0, likes_counter: 0)
    comment = Comment.new(text: 'Test comment', post: post, user: user)
    expect(comment).to be_valid
  end

  it 'is invalid without a post' do
    user = User.create(name: 'Jim', posts_counter: 0)
    Post.create(user: user, title: 'Post for testing', comments_counter: 0, likes_counter: 0)
    comment = Comment.new(user: user)
    expect(comment).to_not be_valid
  end

  describe '#update_comments_counter' do
    it 'updates comments_counter when a comment is saved' do
      user = User.create(name: 'Jim')
      post = Post.create(user: user, title: 'Test Post', text: 'Post text for testing', comments_counter: 0,
                         likes_counter: 0)

      comment = Comment.new(text: 'Comment for test', post: post, user: user)
      expect do
        comment.save
        post.reload
      end.to change(post, :comments_counter).by(1)
    end
  end
end
