class PlayersGames < ActiveRecord::Migration
  def self.up
  	create_table 'playersgames', :id => false do |p|
  		p.boolean :starter
  		p.column 'player_id', :integer
  		p.column 'game_id', :integer
  	end
  end

  def self.down
  	drop_table 'playersgames'
  end
end