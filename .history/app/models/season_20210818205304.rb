class Season < ApplicationRecord
  has_many :spot_seasons
  has_many :spots, through: :spot_seasons
  has_many :flower_item_seasons
  has_many :flower_items, through: :flower_item_seasons
end
