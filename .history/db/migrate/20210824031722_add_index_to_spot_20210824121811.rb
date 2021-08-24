class AddIndexToSpot < ActiveRecord::Migration[6.1]
  def change
    add_index :spots, [:name, :location]
  end
end
