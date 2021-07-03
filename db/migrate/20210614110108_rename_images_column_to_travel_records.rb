class RenameImagesColumnToTravelRecords < ActiveRecord::Migration[6.1]
  def change
    rename_column :travel_records, :images, :image_1
  end
end
