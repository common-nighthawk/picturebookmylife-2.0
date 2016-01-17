class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id
      t.string :title
      t.boolean :featured, default: false, null: false

      t.timestamps
    end
  end
end
