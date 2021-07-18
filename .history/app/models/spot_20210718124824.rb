class Spot < ApplicationRecord
	has_many :flower_item_spots
  has_many :flower_items, through: :flower_item_spots
  has_many :favorites, dependent: :destroy
  belongs_to :area, optional: true
end