class ConvocationsController < ApplicationController
  
  # PUT /convocations/lineup
  # PUT /convocations/lineup.json
  def lineup

    
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

  # GET /convocations/new
  # GET /convocations/new.json
  def new
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @convocation = @game.convocations.new
    players = @team.players
    @available = Array.new
    
    players.each do |player|
      if player.injuries.count > 0
        if !(player.injuries.where(:active => true, :can_play => false).count > 0)
          @available.push(player)
        end
      else
        @available.push(player)
      end
    end

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
      convocation.initial_condition = 0
      
      #if the array doesn't exist it means that nobody went to the practice
      if (params[:player_ids].nil? || params[:player_ids].count < 8)
        redirect_to new_club_team_game_convocation_path(@team.club, @team, @game), notice: 'Error! You need to select at least 8 players to be able to play the game.'
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

  # PUT /convocations
  # PUT /convocations.json
  def update
    @team = Team.find(params[:team_id])
    @game = @team.games.find(params[:game_id])
    @convocations = @game.convocations
    @called = @convocations.where(:called => true)
    @options = params[:selection]
    errors = false

    num_selected_players = @options.count('1')
    if(@options.count > 18)
      num_bench_players = @options.count('2')
      if(num_selected_players != 11 && num_bench_players != 7)
        redirect_to club_team_game_lineup_path(@team.club, @team, @game), notice: 'You must select 11 initial players and 7 player for the bench!'
        return
      end
    else
      if(num_selected_players != 11)
        redirect_to club_team_game_lineup_path(@team.club, @team, @game), notice: 'You must select 11 initial players!'
        return
      end
    end

    respond_to do |format|
      index = 0
      @team.players.each do |player|
        if errors == false
          convocation = @convocations.where(:player_id => player.id).first
          if convocation.called
            if Convocation.update(convocation.id, :initial_condition => @options[index]) == false
              errors = true
            end
          end
          index += 1
        end
      end

      if errors
        format.html { redirect_to club_team_game_lineup_path(@team.club, @team, @game), notice: 'Error selecting lineup!' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
        return
      else
        format.html { redirect_to new_club_team_game_event_path(@team.club, @team, @game), notice: 'Lineup was successfully saved.' }
        format.json { render json: @game, status: :created, location: @game }
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
