class EquipasController < ApplicationController
  # GET /equipas
  # GET /equipas.json
  def index
    @equipas = Equipa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @equipas }
    end
  end

  # GET /equipas/1
  # GET /equipas/1.json
  def show
    @equipa = Equipa.find(params[:id])
    #@clube = Clube.find(@equipa.clube_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @equipa }
    end
  end

  # GET /equipas/new
  # GET /equipas/new.json
  def new
    @equipa = Equipa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @equipa }
    end
  end

  # GET /equipas/1/edit
  def edit
    @equipa = Equipa.find(params[:id])
  end

  # POST /equipas
  # POST /equipas.json
  def create
    clube = Clube.find(1)
    #nota 
    @equipa = clube.equipas.new(params[:equipa])

    respond_to do |format|
      if @equipa.save
        format.html { redirect_to @equipa, notice: 'Equipa was successfully created.' }
        format.json { render json: @equipa, status: :created, location: @equipa }
      else
        format.html { render action: "new" }
        format.json { render json: @equipa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /equipas/1
  # PUT /equipas/1.json
  def update
    @equipa = Equipa.find(params[:id])

    respond_to do |format|
      if @equipa.update_attributes(params[:equipa])
        format.html { redirect_to @equipa, notice: 'Equipa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @equipa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipas/1
  # DELETE /equipas/1.json
  def destroy
    @equipa = Equipa.find(params[:id])
    @equipa.destroy

    respond_to do |format|
      format.html { redirect_to equipas_url }
      format.json { head :no_content }
    end
  end
end
