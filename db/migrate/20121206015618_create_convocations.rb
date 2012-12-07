class CreateConvocations < ActiveRecord::Migration
  def change
    create_table :convocations do |t|
      t.boolean :called
      #stores the information about the information about the initial condition of the player 1->initial lineup
      #2->bench, 3->excluded
      t.integer :initial_condition 
      t.references :player
      t.references :game

      t.timestamps
    end
    add_index "convocations", [:game_id, :player_id], :unique => true
  end
end
