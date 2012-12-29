class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title, :null => false
      t.text :text, :null => false
      t.references :user

      t.timestamps
    end
    add_index :notes, :user_id
  end
end
