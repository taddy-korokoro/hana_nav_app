class ChangeDatatypeLongitudeOfSpots < ActiveRecord::Migration[6.1]
  def up
    change_column :spots, :longitude, :float
  end
end
