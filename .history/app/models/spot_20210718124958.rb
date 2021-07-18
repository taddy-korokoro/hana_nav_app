class Spot < ApplicationRecord
	has_many :flower_item_spots
  has_many :flower_items, through: :flower_item_spots
  has_many :favorites, dependent: :destroy
  belongs_to :area, optional: true

  # 既にお気に入りしていれば「true」を返す
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end