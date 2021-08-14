class Relationship < ApplicationRecord
  belongs_to :followings, class_name: "User"
  belongs_to :followers, class_name: "User"

  validates :follower_id, presence: true
  validates :following_id, presence: true
end
