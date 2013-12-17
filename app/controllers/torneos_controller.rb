class TorneosController < ApplicationController
  before_action :set_torneo, only: [:show, :edit, :update, :destroy]

  # GET /torneos
  # GET /torneos.json
  def index
    @torneos = Torneo.all.order(:cierre_inscripcion).limit(20)
  end

  # GET /torneos/1
  # GET /torneos/1.json
  def show
  end

  # GET /torneos/new
  def new
    @torneo = Torneo.new
  end

  # GET /torneos/1/edit
  def edit
  end

  # POST /torneos
  # POST /torneos.json
  def create
    @torneo = Torneo.new(torneo_params)

    respond_to do |format|
      if @torneo.save
        format.html { redirect_to @torneo, notice: 'Torneo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @torneo }
      else
        format.html { render action: 'new' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /torneos/1
  # PATCH/PUT /torneos/1.json
  def update
    respond_to do |format|
      if @torneo.update(torneo_params)
        format.html { redirect_to @torneo, notice: 'Torneo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /torneos/1
  # DELETE /torneos/1.json
  def destroy
    @torneo.destroy
    respond_to do |format|
      format.html { redirect_to torneos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_torneo
      @torneo = Torneo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def torneo_params
      params.require(:torneo).permit(:nombre, :juego, :vacantes, :cierre_inscripcion)
    end
end
