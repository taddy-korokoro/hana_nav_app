class ChangeDatatypeLongitudeOfSpots < ActiveRecord::Migration[6.1]
  def change
    change_column :spots, :longitude, :float
  end
end
