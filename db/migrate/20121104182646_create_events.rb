class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :code
      t.integer :minute
      t.references :game
      t.references :player

      t.timestamps
    end
    add_index :events, :game_id
  end
end
