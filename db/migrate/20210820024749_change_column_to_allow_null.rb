class ChangeColumnToAllowNull < ActiveRecord::Migration[6.1]
  def up
    change_column :flower_items, :time, :text, null: true
    change_column :flower_items, :feature, :text, null: true
  end

  def down
    change_column :flower_items, :time, :text, null: false
    change_column :flower_items, :feature, :text, null: false
  end
end
