class FlowerItemSpot < ApplicationRecord
	belongs_to :spot
	belongs_to :flower_item
end