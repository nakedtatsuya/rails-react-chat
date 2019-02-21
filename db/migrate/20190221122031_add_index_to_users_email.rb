class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :name, :string
    change_column :users, :email, :string
    add_index :users, :email, unique: true
    add_column :users, :password_digest, :string
  end
end
