class FlowerItem < ApplicationRecord
	has_many :flower_item_spots
  has_many :spots, through: :flower_item_spots
	has_many :flower_item_seasons
  has_many :seasons, through: :flower_item_seasons
end