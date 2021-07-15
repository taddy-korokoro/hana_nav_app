class ChangeDatatypeLatitudeOfSpots < ActiveRecord::Migration[6.1]
  def up
    change_column :spots, :latitude, :float
  end
end
