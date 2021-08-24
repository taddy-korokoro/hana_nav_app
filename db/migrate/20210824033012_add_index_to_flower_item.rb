class AddIndexToFlowerItem < ActiveRecord::Migration[6.1]
  def change
    add_index :flower_items, :name, unique: true
  end
end
