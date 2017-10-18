class RemoveCategoryToEdits < ActiveRecord::Migration[5.0]
  def change
    remove_column :edits, :category, :string
  end
end
