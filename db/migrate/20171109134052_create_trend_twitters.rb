class CreateTrendTwitters < ActiveRecord::Migration[5.0]
  def change
    create_table :trend_twitters do |t|
      t.references :trend, foreign_key: true
      t.references :twitter_datum, foreign_key: true

      t.timestamps
    end
  end
end
