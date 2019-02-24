class AddIndexMessage < ActiveRecord::Migration[5.1]
  def change
    add_index :messages, [:from_id, :to_id]
  end
end
