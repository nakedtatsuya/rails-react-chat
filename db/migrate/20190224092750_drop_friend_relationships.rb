class DropFriendRelationships < ActiveRecord::Migration[5.1]
  def change
    drop_table :friend_relationships
  end
end
