class RenameUserNameColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_columnj :users, :user_name, :name
  end
end
