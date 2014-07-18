class AddFieldsToUser < ActiveRecord::Migration
  # this is only for allowing twitter to login with. provider would be twitter. for multiple accounts you would use association
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string

    add_index :users, [:provider, :uid]
  end
end
