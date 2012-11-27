class PresencesController < ApplicationController

# GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.find(params[:team_id])
    @practice = @team.practices.find(params[:practice_id])
    @presence = @practice.presences.new
    
    respond_to do |format|
      format.html # index.@team.game
      format.json { render json: @practices }
    end
  end
  
  # POST /games
  # POST /games.json
  def create
    @team = Team.find(params[:team_id])
    @practice = @team.practices.find(params[:practice_id])
    @presences = @practice.presences

    #looks on the array for the selected players
    @team.players.each do |player|
      presence = @practice.presences.new
      presence.player_id = player.id
      
      #if the array doesn't exist it means that nobody went to the practice
      if (defined? params[:player_ids])
        presence.present = false
      elsif params[:player_ids].include?(player.id.to_s)
          presence.present = true
        else
          presence.present = false
      end      
      @presences.push(presence)
    end

    @practice.presences_checked = true
    @practice.save
  
    respond_to do |format|
      if @presences.each do |presence| presence.save end
        format.html { redirect_to club_team_practices_path(@team.club, @team), notice: 'Presences were successfully registered.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { redirect_to new_club_team_practice_presence_path(@team.club, @team, @practice), notice: 'Error registering presences!' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

end
