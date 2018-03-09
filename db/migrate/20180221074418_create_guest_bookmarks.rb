class CreateGuestBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :guest_bookmarks do |t|
      t.references :guest, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false

      t.timestamps
    end
  end
end
