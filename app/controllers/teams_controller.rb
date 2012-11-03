class TeamsController < ApplicationController
#  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # GET /teams
  # GET /teams.json
  def index
    @club = Club.find(params[:club_id])
    @teams = @club.teams
    #@games = @teams.games

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @club = Club.find(params[:club_id])
    @team = @club.teams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @club = Club.find(params[:club_id])
    @team = @club.teams.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @club = Club.find(params[:club_id])
    @team = @club.teams.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @club = Club.find(params[:club_id])
    @team = @club.teams.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to club_teams_path(@club), notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: club_teams_path(@club) }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @club = Club.find(params[:club_id])
    @team = @club.teams.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to club_teams_path(@club), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @club = Club.find(params[:club_id])
    @team = @club.teams.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to club_teams_path(@club) }
      format.json { head :no_content }
    end
  end
end
