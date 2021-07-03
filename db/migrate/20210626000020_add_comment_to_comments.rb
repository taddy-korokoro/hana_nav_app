class AddCommentToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :parent, foreign_key: { to_table: :comments }
  end
end
