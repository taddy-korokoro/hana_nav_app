class ChangeDatatypeLatitudeOfSpots < ActiveRecord::Migration[6.1]
  def change
    change_column :spots, :latitude, :float
  end
end
