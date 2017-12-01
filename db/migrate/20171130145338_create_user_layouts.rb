class CreateUserLayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_layouts do |t|
      t.references :user, foreign_key: true
      t.references :layout, foreign_key: true

      t.timestamps
    end
  end
end
