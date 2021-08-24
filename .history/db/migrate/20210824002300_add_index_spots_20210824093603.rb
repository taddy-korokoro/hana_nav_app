class AddIndexSpots < ActiveRecord::Migration[6.1]
  def change
    add_index :spots, [:name, :time, :location, :feature, :image, :url, :latitude, :longitude], name: 'spots'
  end
end
