class AddReferencesToFlowerItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :flower_items, :season, foreign_key: true
  end
end
