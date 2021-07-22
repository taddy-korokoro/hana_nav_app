class AddReferencesToTravelRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :travel_records, :spot, foreign_key: true
  end
end
