class GamesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # GET /games
  # GET /games.json
  def index
    @team = Team.find(params[:team_id])
    @games = @team.games
    @games_not_played = @team.games.where(:played => false).find(:all, :order => "date" )
    @games_played = @team.games.where(:played => true).find(:all, :order => "date DESC")

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
    @players = @game.players.scoped
    @convocations = @game.convocations

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
    @game.lineup_selected = false
    @game.goals_scored = 0
    @game.goals_suffered = 0

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
    @convocations = @game.convocations

    @convocations.each do |convocation|
      convocation.destroy
    end

    @game.destroy

    respond_to do |format|
      #format.html { redirect_to games_url }
      format.html { redirect_to club_team_games_path(@team.club, @team) }
      format.json { head :no_content }
    end
  end

  # PUT 
  def end
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @goals_scored = @game.events.where(:code => 3).count
    @goals_suffered = @game.events.where(:code => 2).count
    
    respond_to do |format|
      if @game.update_attributes(:played => true, :goals_scored => @goals_scored, :goals_suffered => @goals_suffered)
        format.html { redirect_to club_team_games_path(@team.club, @team), notice: 'Game was successfully finished.' }
        format.json { head :no_content }
      else
        format.html { redirect_to new_club_team_game_event_path(@team.club, @team, @game), notice: 'Error finishing game' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  
  #GET lineup
  def lineup
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @convocations = @game.convocations
    @called = @convocations.where(:called => true)

    #if the players were already chosen it redirects automatically to the new event page
    if @convocations.where(:initial_condition => 1).count > 0
      redirect_to new_club_team_game_event_path(@team.club, @team, @game)
    end

    if @called.count < 12
      @called.each do |convocation|
        Convocation.update(convocation.id, :initial_condition => 1)
      end
      redirect_to new_club_team_game_event_path(@team.club, @team, @game)
      return
    end
  end

end
