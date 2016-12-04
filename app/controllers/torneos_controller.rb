class TorneosController < ApplicationController
  require_relative '../../app/helpers/torneos_helper'

  before_action :set_torneo, only: [:preparar, :show, :edit, :update, :destroy, :show_brackets]
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new, :mis_torneos, :iniciar_torneo]

  def ultimo_finalizado
    torneo = Torneo.where(estado: TORNEO_ESTADO_FINALIZADO).last
    teams = torneo.arreglo_de_nombres_para_llaves(3)
    results = TorneosHelper.obtener_array_para_resultado_llaves(torneo,3)
    inscripciones = Inscripcion.inscripciones_permitidas_y_confirmadas_en_el_torneo(torneo)

    json = "{\"detail\": " + torneo.to_json + ",\"teams\": " + teams + " , \"results\": " +  results.to_s + ", \"inscripciones\":" + inscripciones.to_json + " }"

    respond_to do |format|
      format.json { render json: json, status: :ok }
    end
  end

  def ultimo_creado
    @torneo = Torneo.where(estado: TORNEO_ESTADO_CREADO).last
    respond_to do |format|
      format.json { render json: torneo.to_json, status: :ok }
    end
  end

  # GET /torneos GET /torneos.json
  # GET /
  def index
    #@torneos = Torneo.all
    @torneos = Torneo.where( "cierre_inscripcion >= ?", Date.today ).order(cierre_inscripcion: :desc)
    
    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render json: @torneos, status: :ok}
    end

  end

  # GET /torneos/1
  # GET /torneos/1.json
  def show
    chat = Chat.limit(1).offset(49)
    Chat.destroy_all('id < ' + chat[0].id.to_s) unless chat[0].nil?
    @chats = Chat.all.order(:id)
    respond_to do |format|
        format.html { render action: 'show' }
        format.json { render json: Torneo.find(params[:id]), status: :ok }
    end
  end

  attr_writer :attr_names
  # GET /torneos/new
  def new
    @torneo = Torneo.new
    @torneo.estado = 'Pendiente'
    @torneo.urlstreeming = 'http://www.twitch.tv/kripty85'
    @torneo.vacantes = 8
    @torneo.cierre_inscripcion = (Time.new + (60 * 60 * 0.5))
  end

  # GET /torneos/1/edit
  def edit
  end

  # POST /torneos
  # POST /torneos.json
  def create
    @torneo = Torneo.new(torneo_params)
    @torneo.fecha_y_hora_inscripcion(params['cierre_inscripcion_fecha'], params['cierre_inscripcion_hora'])
    @torneo.gamer = current_gamer
    @torneo.periodo_confirmacion_en_minutos = 30
    @torneo.juego = Juego.find(params['juego'].permit(:id)[:id])
    @torneo.estado = 'Creado'
    respond_to do |format|
      if @torneo.save
        @mensaje_de_guardado = 'Torneo creado correctamente'
        format.html { render action: 'show' }
        format.json { render json: @torneo, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
      end
    end
  end

  def chat
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_torneo
    @torneo = Torneo.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { render action: 'show', status: :not_found }
        format.json { render json: 'No existe el torneo', status: :not_found }
      end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def torneo_params
    params.require(:torneo).permit(:titulo, :urlstreeming, :vacantes, :cierre_inscripcion, :post_detalle_torneo, :periodo_confirmacion_en_minutos, :tipo_generacion, :estado, :juego, :urllogo, :urllogoSponsors,:monto_auspiciado)
  end

end
