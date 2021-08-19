class CreateFlowerItemSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :flower_item_seasons do |t|
      t.references  :flower_item,  index: false, foreign_key: true, null: false
      t.references  :season, index: false, foreign_key: true, null: false
      t.timestamps
    end
  end
end
