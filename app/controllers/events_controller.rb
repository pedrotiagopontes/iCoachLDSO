class EventsController < ApplicationController

  # GET /clubs/1/teams/1/games/1/events/new
  # GET /clubs/1/teams/1/games/1/events/new.json
  def new
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @event = @game.events.new
    @initial_players = Array.new
    @bench_players = Array.new
    convocations = @game.convocations

    @team.players.each do |player|
      convocation = convocations.where(:player_id => player.id).first
      if convocation.called
        if convocation.initial_condition == 1
          @initial_players.push(player)
        elsif convocation.initial_condition == 2
          @bench_players.push(player)
        end
      end
    end

    respond_to do |format|
      format.html # index.@team.game
      format.json { render json: @games }
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