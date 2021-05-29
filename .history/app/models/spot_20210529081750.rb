class Spot < ApplicationRecord
	has_many :flower_item_spots
  has_many :flower_items, through: :flower_item_spots
  belongs_to :area, optional: true

  def short_description
    description[0, 9] + '...'
  end
end