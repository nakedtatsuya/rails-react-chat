class AddColumnMessageIsReadedDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :messages, :is_read, :boolean, default: false
  end
end
