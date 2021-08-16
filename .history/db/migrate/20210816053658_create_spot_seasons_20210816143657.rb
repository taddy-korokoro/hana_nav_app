class CreateSpotSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :spot_seasons do |t|

      t.timestamps
    end
  end
end
