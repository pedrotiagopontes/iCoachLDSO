class PlayersPractices < ActiveRecord::Migration
  def self.up
    create_table 'players_practices', :id => false do |t|
      t.column 'player_id', :integer
      t.column 'practice_id', :integer
      t.column 'present', :boolean
    end
  end

  def self.down
  	drop_table 'players_practices'
  end
end