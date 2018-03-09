class AddAdminName < ActiveRecord::Migration[5.1]
  def up
    add_column :admins, :name, :string, default: ""
    add_column :admins, :phone_number, :string, default: ""
  end

  def down
    remove_column :admins, :name
    remove_column :admins, :phone_number
  end
end
