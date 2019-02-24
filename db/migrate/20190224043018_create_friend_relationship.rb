class CreateFriendRelationship < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_relationships do |t|
      t.integer :owner
      t.integer :friend
    end
    add_index :friend_relationships, [:owner, :friend], unique: true
  end
end
