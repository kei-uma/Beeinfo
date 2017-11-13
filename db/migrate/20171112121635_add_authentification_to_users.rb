class AddAuthentificationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column(:users, :authority, :boolean, :default => false, :null => false)
    add_column(:users, :name, :string)
  end
end
