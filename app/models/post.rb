class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  def five_most_recent_comments
   cooments.order(created_at: :desc).limit(5)
  end
end
