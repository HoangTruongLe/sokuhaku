class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :tel, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :token, null: false
      t.boolean :status, null: false
      t.boolean :delete_flg, null: false

      t.timestamps
    end
  end
end
