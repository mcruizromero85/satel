class InscripcionesController < ApplicationController
  before_action :set_inscripcion, only: [:show, :edit, :update, :destroy]

  # GET /inscripciones
  # GET /inscripciones.json
  def index
    @inscripciones = Inscripcion.where(torneo_id:  params[:id_torneo]).order(:created_at)    
  end

  # GET /inscripciones/1
  # GET /inscripciones/1.json
  def show
  end

  # GET /inscripciones/new
  def new    
    @torneo = Torneo.find(params[:id_torneo])
    @inscripcion = Inscripcion.new
  end

  # GET /inscripciones/1/edit
  def edit
  end

  # POST /inscripciones
  # POST /inscripciones.json
  def create
    @inscripcion = Inscripcion.new
    @inscripcion.gamer = current_gamer
    @inscripcion.torneo = Torneo.find(params[:id_torneo])
    @inscripcion.estado = "No confirmado"

    respond_to do |format|
      if @inscripcion.save
        format.html { redirect_to :action => 'index', :id_torneo => params[:id_torneo] }
        format.json { render action: 'show', status: :created, location: @inscripcion }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html {render action: 'new' }
        format.json { render json: @inscripcion.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirmar
    @inscripcion=Inscripcion.find_by(torneo_id: params[:id_torneo],gamer_id: current_gamer.id)
    @inscripcion.estado="Confirmado"

    respond_to do |format|
      if @inscripcion.save
        format.html { redirect_to :action => 'index', :id_torneo => params[:id_torneo] }
        format.json { render action: 'show', status: :created, location: @inscripcion }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html {render action: 'new' }
        format.json { render json: @inscripcion.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /inscripciones/1
  # PATCH/PUT /inscripciones/1.json
  def update

    inscripcion = inscripciones.

    respond_to do |format|
      if @inscripcion.update(inscripcion_params)
        format.html { redirect_to @inscripcion, notice: 'Inscripcion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inscripcion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inscripciones/1
  # DELETE /inscripciones/1.json
  def destroy
    @inscripcion.destroy
    respond_to do |format|
      format.html { redirect_to inscripciones_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inscripcion
      @inscripcion = Inscripcion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inscripcion_params
      params.require(:inscripcion).permit(:torneo_id, :gamer_id, :fecha, :hora)
    end
end
