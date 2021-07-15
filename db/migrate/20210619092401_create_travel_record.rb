class CreateTravelRecord < ActiveRecord::Migration[6.1]
  def change
    create_table :travel_records do |t|
      t.string :title
      t.text :content
      t.string :place
      t.float :review
      t.date :visited_on
      t.string :image_1
      t.string :image_2
      t.string :image_3
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
