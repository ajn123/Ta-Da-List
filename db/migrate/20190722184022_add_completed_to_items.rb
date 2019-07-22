# frozen_string_literal: true

class AddCompletedToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :completed, :boolean, default: 0
  end
end
