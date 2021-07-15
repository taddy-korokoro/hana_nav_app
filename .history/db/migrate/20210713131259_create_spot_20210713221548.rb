class CreateSpot < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string "name", null: false
      t.string "location"
      t.text "feature"
      t.string "image"
      t.string "url"
      t.float "latitude"
      t.float "longitude"
      t.references :area, foreign_key: true
      t.timestamps
    end
  end
end
