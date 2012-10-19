class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :season
      t.string :name
      t.references :club

      t.timestamps
    end
    add_index :teams, :club_id
  end
end
