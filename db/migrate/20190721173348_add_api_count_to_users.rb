# frozen_string_literal: true

class AddApiCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :api_count, :integer, default: 0
  end
end
