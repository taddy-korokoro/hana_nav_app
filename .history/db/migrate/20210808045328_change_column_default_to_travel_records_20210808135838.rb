class ChangeColumnDefaultToTravelRecords < ActiveRecord::Migration[6.1]
  def change
    change_column_default :travel_records, :review, from: nil, to: "0"
  end
end
