class CreateRankings < ActiveRecord::Migration[5.0]
  def change
    create_table :rankings do |t|
      t.integer :edit_id
      t.integer :category_id

      t.timestamps
    end
  end
end
