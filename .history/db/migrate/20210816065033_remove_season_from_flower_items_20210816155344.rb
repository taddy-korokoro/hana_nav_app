class RemoveSeasonFromFlowerItems < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :flower_items, :seasons
    remove_reference :flower_items, :season
  end
end
