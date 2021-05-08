class RenameSeasonColumnToSeasons < ActiveRecord::Migration[6.1]
  def change
    rename_column :season, :season, :month_name
  end
end
