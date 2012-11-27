class CreatePresences < ActiveRecord::Migration
  def change
    create_table :presences do |t|
      t.boolean :present
      t.references :player
      t.references :practice

      t.timestamps
    end
    add_index "presences", [:practice_id, :player_id], :unique => true
  end
end
