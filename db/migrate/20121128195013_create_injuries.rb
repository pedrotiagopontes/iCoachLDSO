class CreateInjuries < ActiveRecord::Migration
  def change
    create_table :injuries do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :can_play
      t.boolean :active
      t.text :description
      t.references :player

      t.timestamps
    end
    add_index :injuries, :player_id
  end
end
