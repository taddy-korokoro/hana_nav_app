class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :season, null: false
      t.text :feature, null: false
      t.string :image
      t.string :url
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
