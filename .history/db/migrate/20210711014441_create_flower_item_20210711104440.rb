class CreateFlowerItem < ActiveRecord::Migration[6.1]
  def change
    create_table :flower_items do |t|

      t.timestamps
    end
  end
end
