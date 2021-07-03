class TravelRecord < ApplicationRecord
  belongs_to :user

  # validates :review, numericality: {less_than_or_equal_to: 5,
  #                   greater_than_or_equal_to: 1}, presence: true

  # 複数画像アップロードの設定
  mount_uploaders :image, ImageUploader
  # SQLiteではJSON型のカラムに対応していないための設定
  serialize :image, JSON
end
