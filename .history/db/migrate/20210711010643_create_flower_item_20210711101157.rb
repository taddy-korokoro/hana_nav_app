class CreateFlowerItem < ActiveRecord::Migration[6.1]
  def change
    create_table :flower_items do |t|
      t.string :name, null: false
      t.string :season, null: false
      t.text :feature, null: false
      t.string :image
      t.references :season, foreign_key: true

      t.timestamps
    end
  end
end
