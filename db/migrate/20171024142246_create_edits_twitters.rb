class CreateEditsTwitters < ActiveRecord::Migration[5.0]
  def change
    create_table :edits_twitters do |t|
      t.references :edit, index: true, foreign_key: true
      t.references :twitter_datum, index: true, foreign_key: true

      t.timestamps
    end
  end
end
