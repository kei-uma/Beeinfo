class AddUserLayoutId < ActiveRecord::Migration[5.0]
  def change
    add_column(:users, :Layout_id, :integer)
  end
end
