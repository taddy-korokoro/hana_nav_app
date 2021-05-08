class AddReferencesToSpots < ActiveRecord::Migration[6.1]
  def change
    add_reference :spots, :area, foreign_key: true
  end
end
