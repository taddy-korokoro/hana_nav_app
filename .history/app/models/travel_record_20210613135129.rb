class TravelRecord < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 32 }
  validates :content, length: { maximum: 300 }
  validates :review, numericality: {
              less_than_or_equal_to: 5,
              greater_than_or_equal_to: 1},
              presence: true

  # 複数画像アップロードの設定
  mount_uploaders :images, ImageUploader
  # SQLiteではJSON型のカラムに対応していないための設定
  serialize :images, JSON
end