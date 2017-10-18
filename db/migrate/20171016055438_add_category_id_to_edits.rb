class AddCategoryIdToEdits < ActiveRecord::Migration
  def up
    add_column(:edits, :category_id, :integer)
    add_index(:edits, :category_id)
  end

  def down
    remove_index(:edits, :column => :category_id)
    remove_column(:edits, :category_id)
  end
end
