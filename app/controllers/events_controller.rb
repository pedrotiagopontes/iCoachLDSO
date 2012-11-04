class EventsController < ApplicationController

  # POST /games
  # POST /games.json
  def create
    @game = Game.find(params[:id])
    @team = @game.team
    @event = @game.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to club_team_games_path(@team.club, @team), notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { redirect_to club_team_games_path(@team.club, @team), notice: 'fail' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

end