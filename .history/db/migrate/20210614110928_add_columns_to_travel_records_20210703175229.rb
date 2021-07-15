class AddColumnsToTravelRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :travel_records, :image_2, :string
    add_column :travel_records, :image_3, :string
  end
end
