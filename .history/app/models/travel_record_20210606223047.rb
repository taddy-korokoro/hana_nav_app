class TravelRecord < ApplicationRecord
  belongs_to :user

  # validates :review, numericality: {less_than_or_equal_to: 5,
  #                   greater_than_or_equal_to: 1}, presence: true

  mount_uploaders :image, ImageUploader
end
