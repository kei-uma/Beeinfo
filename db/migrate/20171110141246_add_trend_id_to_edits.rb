class AddTrendIdToEdits < ActiveRecord::Migration[5.0]
  def change 
    add_column(:edits, :trend_id, :integer)
    add_index(:edits, :trend_id)
  end
end
