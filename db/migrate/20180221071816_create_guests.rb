class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :cookie, null: false
      t.string :token

      t.timestamps
    end
  end
end
