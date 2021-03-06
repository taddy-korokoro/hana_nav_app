class TravelRecord < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :content
    validates :place
    validates :review
    validates :visited_on
  end

  validates :title, length: { maximum: 32 }
  validates :content, length: { maximum: 300 }

  # carrierwave 画像アップロードの設定
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader
  mount_uploader :image_3, ImageUploader

  # Google maps APIの設定
  extend Geocoder::Model::ActiveRecord
  geocoded_by :place
  after_validation :geocode, if: :place_changed?

  # 既にいいねしていれば「true」を返す
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end