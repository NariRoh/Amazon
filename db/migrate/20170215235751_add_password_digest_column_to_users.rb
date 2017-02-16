class AddPasswordDigestColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password_digest, :string
  end
  add_index :users, :email 
end
