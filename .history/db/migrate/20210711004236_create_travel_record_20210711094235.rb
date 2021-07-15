class CreateTravelRecord < ActiveRecord::Migration[6.1]
  def change
    create_table :travel_records do |t|

      t.timestamps
    end
  end
end
