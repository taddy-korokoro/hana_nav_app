class Like < ApplicationRecord
  belongs_to :user
  belongs_to :travel_record

  validates_uniquenss_of :travel_record_id, scope: :user_id
end
