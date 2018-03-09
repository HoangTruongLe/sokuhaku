class RemovePasswordAdmins < ActiveRecord::Migration[5.1]
  def change
    remove_column :admins, :password
  end
end
