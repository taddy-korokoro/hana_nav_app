class Season < ApplicationRecord
  has_many :flower_items
  has_many :spots, through: :flower_items
end
