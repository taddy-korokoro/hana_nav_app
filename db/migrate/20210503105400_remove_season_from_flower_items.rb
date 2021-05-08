class RemoveSeasonFromFlowerItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :flower_items, :season, :string
  end
end
