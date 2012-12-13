class EventsController < ApplicationController

  # GET /clubs/1/teams/1/games/1/events/new
  # GET /clubs/1/teams/1/games/1/events/new.json
  def new
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @event = @game.events.new
    #events in chronoligical order
    @events = @game.events.find(:all, :order => "minute" )
    @initial_players = Array.new
    @bench_players = Array.new
    convocations = @game.convocations
    substitutions = @game.substitutions
    @remaining_substitutions = 3 - substitutions.count

    @team.players.each do |player|
      convocation = convocations.where(:player_id => player.id).first
      if convocation.called
        if convocation.initial_condition == 1
          #loop to check if a player was replaced, and so on
          exit = false
          player_aux = player
          while !exit do
            substitution = substitutions.where(:player_out_id => player_aux.id).first
            if substitution.nil?
              @initial_players.push(player_aux)
              exit = true
            else
              player_aux = @team.players.find(substitution.player_in_id)
            end
          end
        elsif convocation.initial_condition == 2
          substitution = substitutions.where(:player_in_id => player.id).first
          if substitution.nil?
            @bench_players.push(player)
          end
        end
      end
    end

    respond_to do |format|
      format.html # index.@team.game
      format.json { render json: @event }
    end
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.find(params[:game_id])
    @team = @game.team
    @event = @game.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to new_club_team_game_event_path(@team.club, @team, @game), notice: 'Event was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { redirect_to new_club_team_game_event_path(@team.club, @team, @game), notice: 'Error creating an event! Maybe you forgot to insert some required information.' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

end