class Like < ApplicationRecord
  belongs_to :user
  belongs_to :travel_record

  # ユーザーは一つの投稿につき、一回のいいね（制限）
  validates_uniqueness_of :travel_record_id, scope: :user_id
end
