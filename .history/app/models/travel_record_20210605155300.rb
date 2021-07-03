class TravelRecord < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ProfileImageUploader
end
