class PracticesController < ApplicationController
  
  # GET /practices/id/presences
  def presences
    @team = Team.find(params[:team_id])
    @practice = @team.practices.find(params[:practice_id])
    @presences = @practice.presences

    @team.players.each do |player|
      presence = player.presences.new
      presence.player_id = player.id
      presence.practice_id = @practice.id
      presence.present = false
      @presences.push presence
    end
  end


  # GET /practices
  # GET /practices.json
  def index
    @team = Team.find(params[:team_id])
    @practices_realized = @team.practices.where(:presences_checked => true).find(:all, :order => "date DESC" )
    @practices_not_realized = @team.practices.where(:presences_checked => false).find(:all, :order => "date" )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @practices }
    end
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
    @team = Team.find(params[:team_id])
    @practice = @team.practices.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.j  son { render json: @practice }
    end
  end

  # GET /practices/new
  # GET /practices/new.json
  def new
    @team = Team.find(params[:team_id])
    @practice = @team.practices.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @practice }
    end
  end

  # GET /practices/1/edit
  def edit
    @team = Team.find(params[:team_id])
    @practice = @team.practices.find(params[:id])
  end

  # POST /practices
  # POST /practices.json
  def create
    @team = Team.find(params[:team_id])
    @practice = @team.practices.new(params[:practice])
    @practice.presences_checked = false

    respond_to do |format|
      if @practice.save
        format.html { redirect_to club_team_practices_path(@team.club, @team), notice: 'Practice was successfully created.' }
        format.json { render json: @practice, status: :created, location: @practice }
      else
        format.html { render action: "new" }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /practices/1
  # PUT /practices/1.json
  def update
    @team = Team.find(params[:team_id])
    @practice = @team.practices.find(params[:id])

    respond_to do |format|
      if @practice.update_attributes(params[:practice])
        format.html { redirect_to club_team_practices_path(@team.club, @team), notice: 'Practice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @team = Team.find(params[:team_id])
    @practice = @team.practices.find(params[:id])
    @practice.destroy

    respond_to do |format|
      format.html { redirect_to club_team_practices_path(@team.club, @team) }
      format.json { head :no_content }
    end
  end
end
