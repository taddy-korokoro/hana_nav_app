class AddUserNameSelfIntroductionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_name, :string
    add_index :users, :user_name, unique: true
    add_column :users, :self_introduction, :text
  end
end
