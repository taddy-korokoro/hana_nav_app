class CreateScrapings < ActiveRecord::Migration[6.1]
  def change
    create_table :scrapings do |t|

      t.timestamps
    end
  end
end
