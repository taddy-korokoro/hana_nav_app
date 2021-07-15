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
      t.integer "area_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["area_id"], name: "index_spots_on_area_id"
      t.timestamps
    end
  end
end
