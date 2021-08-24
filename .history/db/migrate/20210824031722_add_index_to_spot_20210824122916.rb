class AddIndexToSpot < ActiveRecord::Migration[6.1]
  def change
    add_index :spots, :name, unique: true
    add_index :spots, :location
  end
end
