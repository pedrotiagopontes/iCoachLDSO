class CreateSubstitutions < ActiveRecord::Migration
  def change
    create_table :substitutions do |t|
      t.integer :minute
      t.references :game
      t.references :player_in
      t.references :player_out

      t.timestamps
    end
    add_index :substitutions, :game_id
  end
end
