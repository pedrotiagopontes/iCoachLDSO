class PlayersTeams < ActiveRecord::Migration
  def self.up
    create_table 'playersteams', :id => false do |t|
      t.column 'player_id', :integer
      t.column 'team_id', :integer

      t.timestamps
    end
  end

  def self.down
  	drop_table 'players_teams'
  end
end
