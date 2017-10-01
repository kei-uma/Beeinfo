class CreateEdits < ActiveRecord::Migration[5.0]
  def change
    create_table :edits do |t|
      t.string :user
      t.string :title
      t.date :date
      t.string :category
      t.text :text
      t.string :url

      t.timestamps
    end
  end
end
