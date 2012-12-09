class ClubsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /clubs
  # GET /clubs.json
  def index
    if(current_user)
      @user = User.find(current_user.id) 
      @clubs = @user.clubs
    else
      @clubs = Club.all
    end

    respond_to do |format|
      if(@clubs.length > 0)
        format.html { redirect_to @clubs.first}
        format.json { render json: @clubs.first}
      else
        format.html # index.html.erb
        format.json { render json: @clubs }
      end
    end
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
    #@club = Club.find(params[:id])

    @next_games ||= []
    @club.teams.each do |team|
      game = team.games.order("date").where(:played => false).first
      @next_games << game
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @club }
    end
  end

  # GET /clubs/new
  # GET /clubs/new.json
  def new
    @user = User.find(current_user.id)
    #@club = @user.clubs.build

    #@club = @user.clubs.new
    #@club.users << @user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @club }
    end
  end

  # GET /clubs/1/edit
  def edit
    #@club = Club.find(params[:id])
  end

  # POST /clubs
  # POST /clubs.json
  def create
    @user = User.find(current_user.id)
    #@club = @user.clubs.new(params[:club])
    #@club.save && @club.roles.create(:user => @user, :is_admin => true)

    respond_to do |format|
      if @club.save && @club.roles.create(:user => @user, :is_admin => true)
        format.html { redirect_to @club, notice: 'Club was successfully created.' }
        format.json { render json: @club, status: :created, location: @club }
      else
        format.html { render action: "new" }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clubs/1
  # PUT /clubs/1.json
  def update
 #   @club = Club.find(params[:id])
#    logger.debug(params.inspect)

    params[:club][:user_ids] ||= []
    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
  #  @club = Club.find(params[:id])
    @club.destroy

    respond_to do |format|
      format.html { redirect_to clubs_url }
      format.json { head :no_content }
    end
  end
end
