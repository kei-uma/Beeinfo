class CreateLayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :layouts do |t|
      t.integer :layout

      t.timestamps
    end
  end
end
