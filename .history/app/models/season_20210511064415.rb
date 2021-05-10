class Season < ApplicationRecord
  has_many :flower_items, dependent: :destroy
end
