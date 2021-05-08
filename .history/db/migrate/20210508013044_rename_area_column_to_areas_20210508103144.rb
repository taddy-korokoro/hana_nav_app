class RenameAreaColumnToAreas < ActiveRecord::Migration[6.1]
  def change
    rename_column :areas, :area, :name
  end
end
