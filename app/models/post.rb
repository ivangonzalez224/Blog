class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  after_save :update_user_post_counter

  def five_most_recent_comments
    cooments.order(created_at: :desc).limit(5)
  end

  private

  def update_user_post_counter
    user.update(posts_counter: user.posts.count)
  end
end
