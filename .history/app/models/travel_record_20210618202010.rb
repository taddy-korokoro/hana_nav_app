class TravelRecord < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :place
    validates :visited_on
  end

  validates :title, length: { maximum: 32 }, presence: true
  validates :content, length: { maximum: 300 }, presence: true
  validates :review, numericality: {
              less_than_or_equal_to: 5,
              greater_than_or_equal_to: 1},
              presence: true

  # 画像アップロードの設定
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader
  mount_uploader :image_3, ImageUploader

  # Google maps APIの設定
  extend Geocoder::Model::ActiveRecord
  geocoded_by :place
  after_validation :geocode, if: :place_changed?
end