class GamesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /games
  # GET /games.json
  def index
    @team = Team.find(params[:team_id])
    @games = @team.games

    respond_to do |format|
      format.html # index.@team.games
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @team = Team.find(params[:team_id])
    @game = @team.games.new
    @game.played = false

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @team = Team.find(params[:team_id])
    @game = @team.games.new(params[:game])
    @game.played = false

    respond_to do |format|
      if @game.save
        format.html { redirect_to club_team_games_path(@team.club, @team), notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to club_team_games_path(@team.club, @team), notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:id])
    @game.destroy

    respond_to do |format|
      #format.html { redirect_to games_url }
      format.html { redirect_to club_team_games_path(@team.club, @team) }
      format.json { head :no_content }
    end
  end
end
