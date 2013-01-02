class SynchelperController < ApplicationController
  before_filter :kill_user_session, :authenticate_user!

  respond_to :json
  
	########################################################################################################################
	#	Convocations
	########################################################################################################################
	
  	def conv_create

		@game = Game.find(params[:game_id])
		@team = @game.team
		@player = @team.players.find(params[:player_id])
		@convs = @game.convocations.with_deleted
		
		# Não tem sentido haver a variável called, deveria bastar acrescentar entrada à tabela e está convocado
		if @convs.nil? || @convs.count == 0
			@team.players.each do |player|
				conv = @game.convocations.new
				conv.player_id = player.id
				conv.initial_condition = 0
				conv.called = false
				
				conv.save
				
				@convs.push(conv)
			end
		end

		convocation = @convs.where(:player_id => @player.id).first
		
		@ini_cond = params[:initial_condition]
		if @ini_cond.nil?
			@ini_cond = 0
		end
		
		@called = params[:called]
		if @called.nil?
			@called = true
		end
		
		# Pois, novo player na equipa depois de já haver convocados estoira
		if convocation.nil?
			convocation = @game.convocations.new
			@convs.push(convocation)
		end
		
		convocation.deleted_at = nil
		convocation.player_id = @player.id
		convocation.initial_condition = @ini_cond
		convocation.called = @called;
		
		convocation.save

		render :status => :created, :json => convocation

	end
	
	def conv_destroy
	
		@game = Game.find(params[:game_id])
		convocation = @game.convocations.where(:player_id => params[:player_id]).first
		
		if convocation.nil? 
			head :not_found
		
		else
			convocation.initial_condition = 0
			convocation.called = false
			convocation.save
			
			head :no_content
		end
		
	end
	

	########################################################################################################################
	#	Events
	########################################################################################################################
	
	def event_create
		@game = Game.find(params[:game_id])
		@player_id = params[:player_id]
		@convocation = @game.convocations.where(:player_id => @player_id).first
		
		if @convocation.nil?
			head :not_found

		else
		
			event = @game.events.new
			event.player_id = @player_id
			event.minute = params[:minute]
			event.code = params[:code]
			
			event.save
			
			render :state => :created, :json => event
			
		end
	end
	
	
	########################################################################################################################
	#	Substitutions
	########################################################################################################################
	
	def subst_create
	
		@game = Game.find(params[:game_id])
		@player_in_id = params[:player_in_id]
		@player_out_id = params[:player_out_id]
		
		@convocation_in = @game.convocations.where(:player_id => @player_in_id).first
		@convocation_out = @game.convocations.where(:player_id => @player_out_id).first

		if @convocation_in.nil? || @convocation_out.nil?
			head :not_found

		else
		
			subst = @game.substitutions.new
			subst.player_in_id = @player_in_id
			subst.player_out_id = @player_out_id
			subst.minute = params[:minute]
			
			subst.save
			
			render :state => :created, :json => subst
			
		end
	end
	
	
	
	########################################################################################################################
	#	Update game state
	########################################################################################################################
	

	def game_update_state
		@game = Game.find(params[:game_id])

		@played = params[:played]
		@lineup_selected = params[:lineup_selected]
		@goals_scored = params[:goals_scored]
		@goals_suffered = params[:goals_suffered]

		if ! @played.nil?
			@game.played = @played
		end

		if ! @lineup_selected.nil?
			@game.lineup_selected = @lineup_selected
		end
		
		if ! @goals_scored.nil?
			@game.goals_scored = @goals_scored
		end
		
		if ! @goals_suffered.nil?
			@game.goals_suffered = @goals_suffered
		end
		
		@game.save
		head :no_content
	
	end
	
  
	def kill_user_session
	  if ! current_user.nil?
		sign_out current_user
	  end
	end
	
end
