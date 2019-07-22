# frozen_string_literal: true

class AddIndexToItems < ActiveRecord::Migration[5.2]
  def change
    add_index :items, :list_id
  end
end
