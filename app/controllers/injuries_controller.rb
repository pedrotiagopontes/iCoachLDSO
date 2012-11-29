class InjuriesController < ApplicationController
  # PUT /injuries/1/healed
  # PUT /injuries/1/healed.json
  def healed
    @team = Team.find(params[:team_id])
    @injury = Injury.find(params[:id])
    @injury.active = false

    respond_to do |format|
      if @injury.update_attributes(params[:injury])
        format.html { redirect_to club_team_injuries_path(@team.club, @team), notice: 'Injury was successfully healed.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @injury.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /injuries
  # GET /injuries.json
  def index
    @team = Team.find(params[:team_id])
    @injuries = Injury.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @injuries }
    end
  end

  # GET /injuries/1
  # GET /injuries/1.json
  def show
    @team = Team.find(params[:team_id])
    @injury = Injury.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @injury }
    end
  end

  # GET /injuries/new
  # GET /injuries/new.json
  def new
    @team = Team.find(params[:team_id])
    @injury = Injury.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @injury }
    end
  end

  # GET /injuries/1/edit
  def edit
    @team = Team.find(params[:team_id])
    @injury = Injury.find(params[:id])
  end

  # POST /injuries
  # POST /injuries.json
  def create
    @team = Team.find(params[:team_id])
    @injury = Injury.new(params[:injury])
    @injury.active = true

    respond_to do |format|
      if @injury.save
        format.html { redirect_to club_team_injuries_path(@team.club, @team), notice: 'Injury was successfully created.' }
        format.json { render json: @injury, status: :created, location: @injury }
      else
        format.html { render action: "new" }
        format.json { render json: @injury.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /injuries/1
  # PUT /injuries/1.json
  def update
    @team = Team.find(params[:team_id])
    @injury = Injury.find(params[:id])

    respond_to do |format|
      if @injury.update_attributes(params[:injury])
        format.html { redirect_to club_team_injuries_path(@team.club, @team), notice: 'Injury was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @injury.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /injuries/1
  # DELETE /injuries/1.json
  def destroy
    @team = Team.find(params[:team_id])
    @injury = Injury.find(params[:id])
    @injury.destroy

    respond_to do |format|
      #format.html { redirect_to club_team_injuries_path(@team.club, @team) }
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
