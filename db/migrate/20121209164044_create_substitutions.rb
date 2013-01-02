class CreateSubstitutions < ActiveRecord::Migration
  def change
    create_table :substitutions do |t|
      t.integer :minute, :null => false
      t.references :game, :null => false
      t.references :player_in, :null => false
      t.references :player_out, :null => false

      t.timestamps
    end
    add_index :substitutions, :game_id
  end
end
