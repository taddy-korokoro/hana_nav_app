class Season < ApplicationRecord
  has_many :flower_items, dependent: :destroy
  has_many :spot_seasons
  has_many :spots, through: :spot_seasons
end
