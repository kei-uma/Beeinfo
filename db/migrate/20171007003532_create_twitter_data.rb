class CreateTwitterData < ActiveRecord::Migration[5.0]
  def change
    create_table :twitter_data do |t|
      t.string :trend
      t.text :tweet

      t.timestamps
    end
  end
end
