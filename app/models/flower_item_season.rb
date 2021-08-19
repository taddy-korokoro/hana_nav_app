class FlowerItemSeason < ApplicationRecord
  belongs_to :flower_item
  belongs_to :season
end
