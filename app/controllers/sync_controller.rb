class SyncController < ApplicationController
  before_filter :kill_user_session, :authenticate_user!

  respond_to :json

  def index

    if current_user.nil?
      render :status=>403, :json=>{:error=>'please do login first.'}
      return
    end

    sleep 1.5

    @timeStartD = Time.at( Integer( params[:time].nil? ? 0 : params[:time] ) )
	@timeNowD   = Time.new

	@output = {}

	@output["time_now"] = @timeNowD.to_i
	@output["roles"] 	= []
	@output["clubs"] 	= []
	@output["teams"] 	= []
	@output["players"] 	= []
	@output["injuries"] = []
	@output["games"] 	= []
	@output["events"] 	= []
	@output["notes"] 	= []
	@output["practices"] 	= []
	@output["playersteams"] = []
	@output["convocations"]	= []
	@output["presences"]	= []
	@output["substitutions"] = []
	
	@club_ids   = []
    @team_ids   = []
	@game_ids	= []
	@player_ids	= []
	@practice_ids	= []

	
	
	##################
	# Fetch Roles
	##################

	#Role.with_deleted.where("user_id = ?", current_user.id)
	Role.with_deleted.find_all_by_user_id(current_user.id)
	.each do |v|
		@club_ids << v.club_id
		
		if evaluateTime(v, @timeStartD, @timeNowD)
			@var = {}
			
			#@var["user_id"] = v.user_id
			@var["club_id"] = v.club_id
			@var["is_admin"] = v.is_admin.nil?? false : v.is_admin
			@var["is_coach"] = v.is_coach.nil? ? false : v.is_coach
			@var["is_doctor"] = v.is_doctor.nil? ? false : v.is_doctor
			@var["is_manager"] = v.is_manager.nil? ? false : v.is_manager
			
			set_deleted_at( @var, v )
			convert_time( @var, v )
			@output["roles"] << @var
		end
    end
	@club_ids.uniq!
	
	
	
	##################
	# Fetch Clubs
	##################
	

	Club.where("id IN (?)", @club_ids ).range_where( @timeStartD, @timeNowD )
	.each do |v|      
		@var = {}

		@var["id"] = v.id
		@var["name"] = v.name
		@var["acronym"] = v.acronym

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["clubs"] << @var
    end
	
	
	
	##################
	# Fetch Clubs' Teams
	##################
	
    Team.with_deleted.where("club_id IN (?)", @club_ids )
    .each do |v|      
		@team_ids << v.id

		if evaluateTime(v, @timeStartD, @timeNowD)
			@var = {}

			@var["id"] = v.id
			@var["season"] = v.season
			@var["name"] = v.name
			@var["club_id"] = v.club_id

			set_deleted_at( @var, v )
			convert_time( @var, v )
			@output["teams"] << @var
		end
    end
	@team_ids.uniq!
	
	
	
	##################
	# Fetch Player's Team ids
	##################
	
	Playersteam.with_deleted.where("team_id IN (?)", @team_ids)
	.each do |v|
		@player_ids << v.player_id
		
		if evaluateTime(v, @timeStartD, @timeNowD)
			@var = {}

			@var["team_id"] = v.team_id
			@var["player_id"] = v.player_id

			set_deleted_at( @var, v )
			convert_time( @var, v )
			@output["playersteams"] << @var
		end
	end
	@player_ids.uniq!
	
	
	
	##################
	# Fetch Games
	##################
	
    Game.with_deleted.where("team_id IN (?)", @team_ids )
    .each do |v|
		@game_ids << v.id
		
		if evaluateTime(v, @timeStartD, @timeNowD)
			@var = {}
			
			@var["id"] = v.id
			@var["opponent"] = v.opponent
			@var["date"] = v.date
			@var["hour"] = v.hour
			@var["date_s"] = v.date.to_time.to_i
			@var["hour_s"] = Time.at( v.hour ).to_i
			@var["at_home"] = v.at_home
			@var["played"] = v.played
			@var["team_id"] = v.team_id
			@var["lineup_selected"] = v.lineup_selected
			@var["goals_scored"] = v.goals_scored
			@var["goals_suffered"] = v.goals_suffered

			set_deleted_at( @var, v )
			convert_time( @var, v )
			@output["games"] << @var
		end
	end
	@game_ids.uniq!
	
	
	
	##################
	# Fetch Events
	##################
	
    Event.where("game_id IN (?)" , @game_ids ).range_where( @timeStartD, @timeNowD )
    .each do |v|      
		@var = {}
		
		@var["id"] = v.id
		@var["code"] = v.code
		@var["minute"] = v.minute
		@var["game_id"] = v.game_id
		@var["player_id"] = v.player_id

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["events"] << @var
	end
	
	
	
	##################
	# Fetch Player's Games
	##################
	
	Convocation.where("game_id IN (?)", @game_ids ).range_where( @timeStartD, @timeNowD )
	.each do |v|
		@var = {}

		@var["called"] = v.called
        @var["initial_condition"] = v.initial_condition
		@var["player_id"] = v.player_id
		@var["game_id"] = v.game_id

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["convocations"] << @var
	end
	
	
	
	##################
	# Fetch Players
	##################
	
    Player.where("id IN (?)", @player_ids ).range_where( @timeStartD, @timeNowD )
    .each do |v|      
		@var = {}
		
		@var["id"] = v.id
		@var["number"] = v.number
		@var["name"] = v.name
		@var["height"] = v.height
		@var["date_of_birth_s"] = v.date_of_birth.to_time.to_i
		@var["date_of_birth"] = v.date_of_birth
		@var["nationality"] = v.nationality
		@var["weight"] = v.weight
		@var["position"] = v.position

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["players"] << @var
	end
	
	
	
	##################
	# Fetch Injuries
	##################
	
    Injury.where("player_id IN (?)", @player_ids ).range_where( @timeStartD, @timeNowD )
    .each do |v|      
		@var = {}

		@var["id"] = v.id
		@var["start_date"] = v.start_date
		@var["end_date"] = v.end_date
		@var["start_date_s"] = v.start_date.to_time.to_i
		@var["end_date_s"] = v.end_date.to_time.to_i
		@var["can_play"] = v.can_play
		@var["active"] = v.active
		@var["description"] = v.description
		@var["player_id"] = v.player_id

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["injuries"] << @var
	end
	
	
	
	##################
	# Fetch Practices
	##################
	
    Practice.with_deleted.where("team_id IN (?)", @team_ids )
    .each do |v|      
		@practice_ids << v.id

		if evaluateTime(v, @timeStartD, @timeNowD)
			@var = {}

			@var["id"] = v.id
			@var["date"] = v.date
			@var["hour"] = v.hour
			@var["date_s"] = v.date.to_time.to_i
			@var["hour_s"] = Time.at( v.hour ).to_i
			@var["program"] = v.program
			@var["presences_checked"] = v.presences_checked
			@var["team_id"] = v.team_id

			set_deleted_at( @var, v )
			convert_time( @var, v )
			@output["practices"] << @var
		end
    end
	@practice_ids.uniq!
	
	
	
	##################
	# Fetch Presences
	##################
	
    Presence.where("practice_id IN (?)", @practice_ids ).range_where( @timeStartD, @timeNowD )
    .each do |v|      
		@var = {}
		
		@var["id"] = v.id
		@var["present"] = v.present
		@var["player_id"] = v.player_id
		@var["practice_id"] = v.practice_id

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["presences"] << @var
	end
	
	
	
	
	##################
	# Fetch Notes
	##################
	
    Note.where("user_id = ?", current_user.id ).range_where( @timeStartD, @timeNowD )
    .each do |v|      
		@var = {}
		
		@var["id"] = v.id
		@var["title"] = v.title
		@var["text"] = v.text
                @var["user_id"] = v.user_id

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["notes"] << @var
	end
	
	
	
	##################
	# Substitutions
	##################

	Substitution.where("game_id IN (?)", @game_ids ).range_where( @timeStartD, @timeNowD )
	.each do |v|      
		@var = {}

		@var["id"] = v.id
		@var["minute"] = v.minute
		@var["game_id"] = v.game_id
		@var["player_in_id"] = v.player_in_id
		@var["player_out_id"] = v.player_out_id

		set_deleted_at( @var, v )
		convert_time( @var, v )
		@output["substitutions"] << @var
    end

	
	# and thats all
    render :status=>200, :json=> @output

  end
    


	def kill_user_session
	  if ! current_user.nil?
		sign_out current_user
	  end
	end
	
	def time_to_i( t )
	  if( t.nil? )
		return nil
	  end
	  return Time.at( t ).to_i
	end
	
	def set_deleted_at( var , vin )
		var["deleted_at"] = time_to_i( vin.deleted_at )
	end
	
	def convert_time(var, vin)
	  var["created_at"] = time_to_i( vin.created_at )
	  var["updated_at"] = time_to_i( vin.updated_at )
	end

	def evaluateTime( vin, timeS, timeN )
	    @delS = ( !vin.deleted_at.nil? && vin.deleted_at >= timeS ) ? true : false
		@delN = ( vin.deleted_at.nil? || vin.deleted_at < timeN ) ? true : false
		
		return ( ( vin.created_at >= timeS || vin.updated_at >= timeS || @delS ) && vin.created_at < timeN && vin.updated_at < timeN && @delN )
	end
	
	class ActiveRecord::Base
		def self.range_where ( timeS, timeN )
			with_deleted.where(" (created_at >= ? OR updated_at >= ? OR (deleted_at IS NOT NULL AND deleted_at >= ?)) " <<
									" AND created_at < ? AND updated_at < ? AND (deleted_at IS NULL OR deleted_at < ?) ",
								timeS, timeS, timeS, timeN, timeN, timeN )
		end
	end

end
