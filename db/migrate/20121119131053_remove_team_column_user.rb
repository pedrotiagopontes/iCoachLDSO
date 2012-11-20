class RemoveTeamColumnUser < ActiveRecord::Migration
  def up
  	change_table :players do |t|
  		t.remove :team_id
  	end
  end
end
