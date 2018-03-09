class CreateUserBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
