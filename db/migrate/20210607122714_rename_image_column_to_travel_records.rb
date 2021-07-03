class RenameImageColumnToTravelRecords < ActiveRecord::Migration[6.1]
  def change
    rename_column :travel_records, :image, :images
  end
end
