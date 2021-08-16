class CreateSpotSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :spot_seasons do |t|
      t.references  :spot,  index: false, foreign_key: true, null: false
      t.references  :season, index: false, foreign_key: true, null: false
      t.timestamps
    end
  end
end
