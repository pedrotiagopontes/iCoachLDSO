class PlayersController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
	
	def create
		@team = Team.find(params[:team_id])
		@player = @team.players.create(params[:player])
		redirect_to team_path(@team)
	end
end
