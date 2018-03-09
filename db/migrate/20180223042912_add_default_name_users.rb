class AddDefaultNameUsers < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :name, :string, default: ""
    change_column :users, :tel, :string, default: ""
    change_column :users, :status, :boolean, default: false
    change_column :users, :delete_flg, :boolean, default: false
    remove_column :users, :password
    remove_column :users, :token
  end

  def down
  end
end
