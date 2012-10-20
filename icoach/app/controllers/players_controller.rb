class PlayersController < ApplicationController
	@team = Team.find(params[:team_id])
	@player = @team.players.create(params[:player])
	redirect_to team_path(@team)
end
