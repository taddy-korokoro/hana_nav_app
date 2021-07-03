class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :travel_record
  # belongs_to :parent, class_name: "Comment", optional: true # nilを許可することで返信でない通常コメントも登録できるようにする
  # has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 300 }
end
