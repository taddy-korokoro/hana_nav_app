class RenameTarvelRecordIdColumnToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :tarvel_record_id, :travel_record_id
  end
end
