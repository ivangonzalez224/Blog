require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with a post_id' do
    user = User.create(name: 'Jim', posts_counter: 0)
    post = Post.create(user: user, title: 'Post for testing', text: 'Post text for testing', comments_counter: 0,
                       likes_counter: 0)
    like = Like.new(post: post, user: user)
    expect(like).to be_valid
  end

  describe '#update_comments_counter' do
    it 'updates the likes_counter when a like is created' do
      user = User.create(name: 'Jim', posts_counter: 0)
      post = Post.create(user: user, title: 'Test Post', text: 'Post text for testing', comments_counter: 0,
                         likes_counter: 0)

      like = Like.new(post: post, user: user)
      like.save

      post.reload

      expect(post.likes_counter).to eq(1)
    end
  end
end
