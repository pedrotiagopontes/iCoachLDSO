class ConvocationsController < ApplicationController
  # GET /convocations/new
  # GET /convocations/new.json
  def new
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @convocation = @game.convocations.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # POST /convocations
  # POST /convocations.json
  def create
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @convocations = @game.convocations

    #looks on the array for the selected players
    @team.players.each do |player|
      convocation = @game.convocations.new
      convocation.player_id = player.id
      
      #if the array doesn't exist it means that nobody went to the practice
      if (params[:player_ids].nil? || params[:player_ids].count < 11)
        redirect_to new_club_team_game_convocation_path(@team.club, @team, @game), notice: 'Error! You need to select at least 11 players.'
        return
      elsif params[:player_ids].include?(player.id.to_s)
          convocation.called = true
        else
          convocation.called = false
      end      
      @convocations.push(convocation)
    end

    #@game.presences_checked = true
    #@game.save
  
    respond_to do |format|
      if @convocations.each do |convocation| convocation.save end
        format.html { redirect_to club_team_games_path(@team.club, @team), notice: 'Selection of players was successfully saved.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { redirect_to new_club_team_game_convocation_path(@team.club, @team, @game), notice: 'Error selecting players!' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

=begin
  # GET /convocations/editselection
  # GET /convocations/editselection.json
  def edit
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:id])
    @convocations = @game.convocations
    @convocation = Convocation.new
  end

  # PUT /convocations
  # PUT /convocations.json
  def update
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:id])
    @convocations = @game.convocations

    #looks on the array for the selected players
    @team.players.each do |player|      
      #if the array doesn't exist it means that nobody went to the practice
      if (params[:player_ids].nil? || params[:player_ids].count < 11)
        redirect_to edit_club_team_game_convocation_path(@team.club, @team, @game), notice: 'Error! You need to select at least 11 players.'
        return
      elsif params[:player_ids].include?(player.id.to_s)
          @convocations.where(:player_id => player.id).first.called = true
        else
          @convocations.where(:player_id => player.id).first.called = false
      end      
    end

    #@game.presences_checked = true
    #@game.save
  
    respond_to do |format|
      if @convocations.each do |convocation| convocation.update_attributes end
        format.html { redirect_to club_team_games_path(@team.club, @team), notice: 'Selection of players was successfully saved.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { redirect_to edit_club_team_game_convocation_path(@team.club, @team, @game), notice: 'Error selecting players!' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
=end
end
