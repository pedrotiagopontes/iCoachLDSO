class SubstitutionsController < ApplicationController

	# /games/:game_id/substitution/new
	def new
		@team = Team.find(params[:team_id])
    	@game = @team.games.find(params[:game_id])
    	@substitution = @game.substitutions.new
    	@initial_players = Array.new
	    @bench_players = Array.new
	    convocations = @game.convocations
	    substitutions = @game.substitutions

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

	def create
		@game = Game.find(params[:game_id])
    	@team = @game.team
    	@substitution = @game.substitutions.new(params[:substitution])

    	respond_to do |format|
	      if @substitution.save
	        format.html { redirect_to new_club_team_game_event_path(@team.club, @team, @game), notice: 'Substitution was successfully done.' }
	        format.json { render json: @substitution, status: :created, location: @substitution }
	      else
	        format.html { redirect_to new_club_team_game_event_path(@team.club, @team, @game), :flash => { :error => 'Error while doing the substitution! Maybe you forgot to insert some required information.'} }
	        format.json { render json: @substitution.errors, status: :unprocessable_entity }
	      end
	    end
	end

end
