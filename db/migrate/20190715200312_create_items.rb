class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :content
      t.datetime :due_date
      t.integer :list_id
    end
  end
end
