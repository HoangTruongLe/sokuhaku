class CreateClickings < ActiveRecord::Migration[5.1]
  def change
    create_table :clickings do |t|
      t.references :room, foreign_key: true
      t.string :cookie
      t.references :user, foreign_key: true, null: true

      t.timestamps
    end
  end
end
