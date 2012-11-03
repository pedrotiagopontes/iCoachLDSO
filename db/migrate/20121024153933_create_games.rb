class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :opponent
      t.date :date
      t.time :hour
      t.boolean :at_home
      t.boolean :played
      t.references :team

      t.timestamps
    end
    add_index :games, :team_id
  end
end
