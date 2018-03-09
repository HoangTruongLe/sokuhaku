class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :service_id
      t.references :host, foreign_key: true, null: true
      t.integer :site_kinds

      t.timestamps
    end
  end
end
