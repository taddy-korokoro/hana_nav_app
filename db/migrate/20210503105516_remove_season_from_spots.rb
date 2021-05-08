class RemoveSeasonFromSpots < ActiveRecord::Migration[6.1]
  def change
    remove_column :spots, :season, :string
  end
end
