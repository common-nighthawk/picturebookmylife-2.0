class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :book_id
      t.integer :position
      t.string :flickr_photo_id
      t.text :text

      t.timestamps
    end
  end
end
