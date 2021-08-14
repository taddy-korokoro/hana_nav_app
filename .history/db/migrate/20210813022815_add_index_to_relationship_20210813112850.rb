class AddIndexToRelationship < ActiveRecord::Migration[6.1]
  def change
    add_index :relationships, [:follower_id, :following_id], unique: true
  end
end
