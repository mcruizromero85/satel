class InscripcionesController < ApplicationController
  before_action :revisa_si_existe_gamer_en_sesion, only: [:show_by_tournament, :new, :create, :index]

  # GET /inscripciones
  # GET /inscripciones.json
  def index
    @inscripciones = Inscripcion.where(torneo_id:  params[:id_torneo]).order(:created_at)
    @torneo = Torneo.find(params[:id_torneo])
    @mensaje_inscripcion = params[:mensaje_inscripcion]
  end


  # GET /inscripciones/new
  def new
    @torneo = Torneo.find(params[:id_torneo])
    @inscripcion = Inscripcion.new
    @mensaje_inscripcion_error = params[:mensaje_inscripcion_error] unless params[:mensaje_inscripcion_error].nil?
  end

  # GET /inscripciones/1/edit
  def edit
  end

  # POST /inscripciones
  # POST /inscripciones.json
  def create
    @torneo = Torneo.find_by(torneo_params)
    @current_gamer.correo = params[:email]
    @current_gamer.battletag = params[:battletag]
    @current_gamer.save
    @inscripcion = Inscripcion.new(gamer: current_gamer, torneo: @torneo)    
    respond_to do |format|
      if @inscripcion.inscribir
        format.html { render action: 'index' }
        format.json { render json: @inscripcion, status: :created }
      else          
        format.html { render action: 'new' }
        format.json { render json: @inscripcion.errors.full_messages.to_json , status: :not_acceptable }
      end
    end
  end

  def confirmar
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    @inscripcion.estado = 'Confirmado'
    respond_to do |format|
      if @inscripcion.save
        format.html { redirect_to action: 'show', controller: 'torneos', id: params[:id_torneo]}
        format.json { render json: @inscripcion, status: :created }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html { render action: 'new' }
        format.json { render json: @inscripcion.errors.full_messages.to_json , status: :not_acceptable }
      end
    end
  end
  # DELETE /gamers/1
  # DELETE /gamers/1.json
  def destroy
    inscripcion = Inscripcion.find(params[:id])
    inscripcion.destroy if current_gamer.id == inscripcion.gamer.id || current_gamer.id == inscripcion.torneo.gamer.id
    respond_to do |format|
      format.html { redirect_to action: 'index', id_torneo: inscripcion.torneo.id }
      format.json { head :no_content }
    end
  end

  private

  def torneo_params
    params.require(:torneo).permit(:id)
  end
  
end
