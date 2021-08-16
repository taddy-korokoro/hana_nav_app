class FlowerItem < ApplicationRecord
	has_many :flower_item_spots
  has_many :spots, through: :flower_item_spots
end