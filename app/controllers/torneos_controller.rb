class TorneosController < ApplicationController
  require_relative '../../app/helpers/torneos_helper'

  before_action :set_torneo, only: [:preparar, :show, :edit, :update, :destroy]
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new, :mis_torneos, :iniciar_torneo]
  before_filter :set_access

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

  # GET /torneos GET /torneos.json
  def index
    @suscription = Suscription.new
    @torneos_inscritos_y_confirmados = []
    @torneos_finalizados = Torneo.where(estado: TORNEO_ESTADO_FINALIZADO)
    @torneos_iniciados = Torneo.obtener_torneos_iniciados(current_gamer)
    if !current_gamer.nil?
      @torneos_inscritos_y_confirmados.concat(@torneos_iniciados) if @torneos_iniciados.size > 0
      @torneos_confirmados = Torneo.obtener_torneos_ya_confirmados(current_gamer)
      if @torneos_confirmados.size > 0
        @torneos_inscritos_y_confirmados.concat(@torneos_confirmados)
      end
      @torneos_inscritos = Torneo.obtener_torneos_ya_inscrito(current_gamer)
      @torneos_inscrito_con_pago = Torneo.obtener_torneos_ya_inscrito(current_gamer, 1)
      @torneos_inscritos_y_confirmados.concat(@torneos_inscritos)
      @torneos_inscritos_y_confirmados.concat(@torneos_inscrito_con_pago)
    else
      @torneos_confirmados = []
      @torneos_inscritos = []
      @torneos_inscrito_con_pago = []
    end
    if @torneos_inscritos_y_confirmados.size == 0
      @torneos = Torneo.obtener_torneos_disponibles_para_inscribir
    else
      @torneos = Torneo.obtener_torneos_disponibles_para_inscribir(@torneos_inscritos_y_confirmados.map(&:id))
    end
      @torneo = @torneos_finalizados.last

    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render json: @torneos, status: :ok}
    end

  end

  # GET /torneos/1
  # GET /torneos/1.json
  def show
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
    @torneo.juego = Juego.find(params['juego'].permit(:id)[:id])
    @torneo.estado = 'Creado'
    respond_to do |format|
      if @torneo.save
        DetallePagoInscripcion.create(monto_inscripcion: 0.0, monto_auspiciado: 0.0, torneo_id: @torneo.id)
        @mensaje_de_guardado = 'Torneo creado correctamente'
        format.html { render action: 'show' }
        format.json { render json: @torneo, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
      end
    end
  end

  def mis_torneos
    @torneos = Torneo.all.where('gamer_id = :gamer_id ', gamer_id: current_gamer.id).order(cierre_inscripcion: :asc)
  end

  def iniciar_torneo
    chat = Chat.limit(1).offset(49)
    Chat.destroy_all('id < ' + chat[0].id.to_s) unless chat[0].nil?
    @chats = Chat.all.order(:id)
    @torneo = Torneo.find(params[:id_torneo])
    #@torneo.generar_encuentros if current_gamer == @torneo.gamer
    return if @torneo.gamer == current_gamer || !current_gamer.esta_confirmado(@torneo)

    encuentro_actual = current_gamer.encuentro_actual(@torneo)
    return if encuentro_actual.nil?

    if encuentro_actual.estado == 'Pendiente'
      if encuentro_actual.updated_at.to_i + TIME_OUT_LISTO_GAMER_EN_SEGUNDOS <= Time.new.to_i && current_gamer.esta_listo_en_encuentro_actual(@torneo) && !current_gamer.esta_listo_contrincante_en_encuentro_actual(@torneo)
        encuentro_actual.gamerinscrito_ganador = Inscripcion.new(id: current_gamer.inscripcion_en_torneo(@torneo).id)
        encuentro_actual.registrar_ganador(true)
      elsif encuentro_actual.updated_at.to_i + TIME_OUT_LISTO_GAMER_EN_SEGUNDOS <= Time.new.to_i && !current_gamer.esta_listo_en_encuentro_actual(@torneo) && current_gamer.esta_listo_contrincante_en_encuentro_actual(@torneo)
        encuentro_actual.gamerinscrito_ganador = Inscripcion.new(id: current_gamer.contrincante_inscrito_actual(@torneo).id)
        encuentro_actual.registrar_ganador(true)
      end
    elsif encuentro_actual.estado == 'Iniciado'
      if encuentro_actual.partida_actual.updated_at.to_i + TIME_OUT_LIMITE_PARA_DEBATE_DE_PARTIDA_EN_SEGUNDOS <= Time.new.to_i && current_gamer.reporto_ganar_partida_actual(@torneo) && !current_gamer.reporto_ganar_partida_actual_el_contrincante(@torneo)
        encuentro_actual.gamerinscrito_ganador = Inscripcion.new(id: current_gamer.inscripcion_en_torneo(@torneo).id)
        encuentro_actual.registrar_ganador
      elsif encuentro_actual.partida_actual.updated_at.to_i + TIME_OUT_LIMITE_PARA_DEBATE_DE_PARTIDA_EN_SEGUNDOS <= Time.new.to_i && !current_gamer.reporto_ganar_partida_actual(@torneo) && current_gamer.reporto_ganar_partida_actual_el_contrincante(@torneo)
        encuentro_actual.gamerinscrito_ganador = Inscripcion.new(id: current_gamer.contrincante_inscrito_actual(@torneo).id)
        encuentro_actual.registrar_ganador
      end
    end
  end

  def comenzar
    @torneo = Torneo.find_by(id: params[:id_torneo], gamer_id: current_gamer.id)
    @torneo.estado = params['estado']
    respond_to do |format|
      if @torneo.save
        @torneo.generar_encuentros
        format.html { redirect_to action: 'iniciar_torneo', id_torneo: @torneo.id }
      else
        @torneo.estado = 'Creado'
        format.html { render action: 'iniciar_torneo', notice: 'Error' }
      end
    end
  end

  def formulario_torneo_relampago
    @torneo = Torneo.find(params[:id_torneo])
  end

  def agregar_gamers_temporales
    torneo = Torneo.find_by(id: params[:id_torneo], gamer_id: current_gamer.id, estado: 'Creado')
    gamers_array = params['gamers']

    gamers_array.each_line do | gamer_temporal_nick |
      gamer_temporal_nick = gamer_temporal_nick.strip
      gamer = Gamer.new(correo: gamer_temporal_nick + '@temporal.com', apellidos: gamer_temporal_nick)
      gamer.nombres = gamer_temporal_nick + '_temporal'
      gamer.nick = gamer_temporal_nick
      gamer.save

      authentication = Authentication.new(provider: 'temporal', uid: gamer.correo, gamer: gamer)
      authentication.save

      inscripcion = Inscripcion.new
      inscripcion.gamer = gamer
      inscripcion.nick = gamer_temporal_nick
      inscripcion.torneo = torneo
      inscripcion.estado = 'Confirmado'
      inscripcion.save
    end
    respond_to do |format|
      format.html { redirect_to action: 'iniciar_torneo', id_torneo: torneo.id }
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
    params.require(:torneo).permit(:titulo, :urlstreeming, :vacantes, :cierre_inscripcion, :post_detalle_torneo, :periodo_confirmacion_en_minutos, :tipo_generacion, :estado, :juego)
  end

  def set_access
    headers["Access-Control-Allow-Origin"] = "*"
  end
end
