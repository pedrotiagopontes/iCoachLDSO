class NotesController < ApplicationController
  # GET /notes
  # GET /notes.json
  def index
    @user = User.find(current_user.id) 
    @notes = Note.where(:user_id => @user.id).find(:all, :order => "updated_at DESC" )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])
    @user = User.find(current_user.id) 

    if @note.user_id != @user.id
      redirect_to notes_path, notice: 'You don\'t have permission to read this note.'
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @user = User.find(current_user.id) 
    @note = @user.notes.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @user = User.find(current_user.id)
    @note = Note.find(params[:id])

    if @note.user_id != @user.id
      redirect_to notes_path, notice: 'You don\'t have permission to edit this note.' 
      return
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @user = User.find(current_user.id) 
    @note = Note.new(params[:note])
    @note.user_id = @user.id

    respond_to do |format|
      if @note.save
        format.html { redirect_to :back, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to :back, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end
end
