class AddDetailedFeatureToFlowerItem < ActiveRecord::Migration[6.1]
  def change
    add_column :flower_items, :detailed_feature, :text
  end
end
