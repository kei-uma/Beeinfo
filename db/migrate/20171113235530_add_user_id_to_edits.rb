class AddUserIdToEdits < ActiveRecord::Migration[5.0]
  def change
    add_column(:edits, :User_id, :integer)
    add_index(:edits, :User_id)
    remove_column(:edits, :user, :string)
  end
end
