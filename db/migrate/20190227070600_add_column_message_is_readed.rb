class AddColumnMessageIsReaded < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :is_read, :boolean
  end
end
