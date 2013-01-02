class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :code, :null => false
      t.integer :minute, :null => false
      t.references :game, :null => false
      t.references :player, :null => false

      t.timestamps
    end
    add_index :events, :game_id
  end
end
