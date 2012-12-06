class PlayersgameController < ApplicationController

# GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.find(params[:team_id])
    @club = @team.club
    @game = Game.find(params[:game_id])
    @playersgame = @game.playersgames.new
    
    respond_to do |format|
      format.html # index.@team.game
      format.json { render json: @playersgame}
    end
  end
  
  # POST /games
  # POST /games.json
  def create
    @team = Team.find(params[:team_id])
    @game = Game.find(params[:game_id])
    @playersgames = @game.playersgames

    #looks on the array for the selected players
    @team.players.each do |player|
      playersgame = @game.playersgames.new
      playersgame.player_id = player.id
      
    #   #if the array doesn't exist it means that nobody went to the practice
    #   if (defined? params[:player_ids])
    #     presence.present = false
    #   elsif params[:player_ids].include?(player.id.to_s)
    #       presence.present = true
    #     else
    #       presence.present = false
    #   end      
    #   @presences.push(presence)
    end

    #@practice.presences_checked = true
    @playersgames.save
  
    respond_to do |format|
      if @playersgames.each do |playersgame| playersgame.save end
        format.html { redirect_to club_team_game_path(@team.club, @team), notice: 'Calls were successfully registered.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { redirect_to new_club_team_practice_playersgame_path(@team.club, @team, @practice), notice: 'Error registering Calls!' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

end
