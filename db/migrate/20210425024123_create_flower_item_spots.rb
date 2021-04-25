class CreateFlowerItemSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :flower_item_spots do |t|
      t.references  :spot,  index: false, foreign_key: true, null: false
      t.references  :flower_item, index: false, foreign_key: true, null: false

      t.timestamps
    end
  end
end
