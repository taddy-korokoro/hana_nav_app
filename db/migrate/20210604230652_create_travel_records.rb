class CreateTravelRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :travel_records do |t|
      t.string :title
      t.text :content
      t.string :place
      t.float :review
      t.date :visited_on
      t.string :image
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
