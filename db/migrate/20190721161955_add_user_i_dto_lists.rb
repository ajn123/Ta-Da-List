class AddUserIDtoLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :user_id, :integer
    add_index  :lists, :user_id
  end
end
