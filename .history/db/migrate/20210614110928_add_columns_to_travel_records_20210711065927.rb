class AddColumnsToTravelRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :travel_records, :image_2, :string, after: :image_1
    add_column :travel_records, :image_3, :string, after: :image_1
  end
end
