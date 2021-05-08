class Spot < ApplicationRecord
	has_many :flower_item_spots
  has_many :flower_items, through: :flower_item_spots
end