require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with content and a post_id' do
    user = User.create(name: 'Jim', posts_counter: 0)
    post = Post.create(user: user, title: 'Post for testing', comments_counter: 0, likes_counter: 0)
    comment = Comment.new(text: 'Test comment', post: post, user: user)
    expect(comment).to be_valid
  end
end  