class InscripcionesController < ApplicationController
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new]

  # GET /inscripciones
  # GET /inscripciones.json
  def index
    @inscripciones = Inscripcion.where(torneo_id:  params[:id_torneo], tipo_inscripcion: nil).order(:created_at)
    @mensaje_inscripcion = params[:mensaje_inscripcion]
  end

  # GET /inscripciones/1
  # GET /inscripciones/1.json
  def show
  end

  # GET /inscripciones/new
  def new
    @torneo = Torneo.find(params[:id_torneo])
    @inscripcion = Inscripcion.new
    @datos_requeridos = DatosInscripcion.where(torneo_id:  params[:id_torneo])
  end

  # GET /inscripciones/1/edit
  def edit
  end

  # POST /inscripciones
  # POST /inscripciones.json
  def create
    gamer_params = params.require(:gamer).permit(:nick)
    current_gamer.nick = gamer_params[:nick]
    current_gamer.save
    @inscripcion = Inscripcion.new
    @inscripcion.gamer = current_gamer
    @inscripcion.torneo = Torneo.find(params[:id_torneo])
    contador = 0
    loop do
      break if params['datos_inscripcion_registrado' + contador.to_s].nil?
      dato_inscripcion_registrado = DatosInscripcionRegistrado.new(params['datos_inscripcion_registrado' + contador.to_s].permit(:valor))
      dato_inscripcion_registrado.datos_inscripcion = DatosInscripcion.find(params['datos_inscripcion_registrado' + contador.to_s].permit(:datos_inscripcion_id)[:datos_inscripcion_id])
      @inscripcion.agregar_dato_inscripcion_registrado(dato_inscripcion_registrado)
      contador += 1
    end

    respond_to do |format|
      if @inscripcion.inscribir
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
      else
        @torneo = Torneo.find(params[:id_torneo])
        @datos_requeridos = DatosInscripcion.where(torneo_id:  params[:id_torneo])
        format.html { render action: 'new' }
      end
    end
  end

  def confirmar
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    @inscripcion.estado = 'Confirmado'

    respond_to do |format|
      if @inscripcion.confirmar
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html { render action: 'new' }
      end
    end
  end
  # DELETE /gamers/1
  # DELETE /gamers/1.json
  def destroy
    inscripcion = Inscripcion.find(params[:id])
    inscripcion.destroy
    respond_to do |format|
      format.html { redirect_to action: 'index', id_torneo: inscripcion.torneo.id }
      format.json { head :no_content }
    end
  end
end
