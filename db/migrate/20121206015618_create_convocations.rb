class CreateConvocations < ActiveRecord::Migration
  def change
    create_table :convocations do |t|
      t.boolean :called
      t.references :player
      t.references :game

      t.timestamps
    end
    add_index "convocations", [:game_id, :player_id], :unique => true
  end
end
