class PlayersController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
	
	def create
		@team = Team.find(params[:team_id])
		@player = @team.players.create(params[:player])
		redirect_to club_team_path(@team.club, @team)
	end

	def edit
	  @club = Club.find(params[:club_id])
	  @team = Team.find(params[:team_id])
	  @player = @team.players.find(params[:id])
	end

	def update
	  @club = Club.find(params[:club_id])
	  @team = Team.find(params[:team_id])
	  @player = @team.players.find(params[:id])

	  respond_to do |format|
	    if @player.update_attributes(params[:player])
	      format.html { redirect_to club_team_path(@club, @team), notice: 'Player was successfully updated.' }
	      format.json { head :no_content }
	    else
	      format.html { render action: "edit" }
	      format.json { render json: @player.errors, status: :unprocessable_entity }
	    end
	  end
	end

	def destroy
	  @club = Club.find(params[:club_id])
	  @team = Team.find(params[:team_id])
	  @player = @team.players.find(params[:id])
	  @player.destroy

	  respond_to do |format|
	    format.html { redirect_to club_team_path(@team.club, @team)}
	    format.json { head :no_content }
	  end
	end

	def show
	  @team = Team.find(params[:team_id])
	  @player = @team.players.find(params[:id])
	  @active_injuries = @player.injuries.where(:active => true)
	  @old_injuries = @player.injuries.where(:active => false)
	  

	  respond_to do |format|
      	format.html # show.html.erb
      	format.json { render json: @game }
   	  end
	end
end