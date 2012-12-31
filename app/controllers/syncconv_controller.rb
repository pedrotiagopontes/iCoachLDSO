class SyncconvController < ApplicationController
  before_filter :kill_user_session, :authenticate_user!

  respond_to :json

	def create

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
	
	def destroy
	
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
	
	
  
	def kill_user_session
	  if ! current_user.nil?
		sign_out current_user
	  end
	end
	
end
