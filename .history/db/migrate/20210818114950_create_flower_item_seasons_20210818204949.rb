class CreateFlowerItemSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :flower_item_seasons do |t|

      t.timestamps
    end
  end
end
