class TorneosController < ApplicationController
  require_relative '../../app/helpers/torneos_helper'

  before_action :set_torneo, only: [:preparar, :show, :edit, :update, :destroy]
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new, :mis_torneos]

  # GET /torneos GET /torneos.json
  def index
    @torneos_inscritos_y_confirmados = []
    if !current_gamer.nil?
      @torneos_iniciados = Torneo.obtener_torneos_iniciados(current_gamer)
      @torneos_inscritos_y_confirmados = @torneos_iniciados if @torneos_iniciados.size > 0
      @torneos_confirmados = Torneo.obtener_torneos_ya_confirmados(current_gamer)

      if @torneos_confirmados.size > 0
        @torneos_inscritos_y_confirmados.concat(@torneos_confirmados)
      end

      @torneos_inscritos = Torneo.obtener_torneos_ya_inscrito(current_gamer)
      @torneos_inscritos_y_confirmados.concat(@torneos_inscritos)
    else
      @torneos_iniciados = []
      @torneos_confirmados = []
      @torneos_inscritos = []
    end
    if @torneos_inscritos_y_confirmados.size == 0
      @torneos = Torneo.obtener_torneos_disponibles_para_inscribir
    else
      @torneos = Torneo.obtener_torneos_disponibles_para_inscribir(@torneos_inscritos_y_confirmados.map(&:id))
    end
  end

  # GET /torneos/1
  # GET /torneos/1.json
  def show
    @mensaje_de_guardado = params[:notice]
    respond_to do |format|
      format.html { render action: 'show', notice: 'Torneo creado correctamente' }      
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
        @mensaje_de_guardado = 'Torneo creado correctamente'
        format.html { render action: 'show'}
      else
        format.html { render action: 'new' }
      end
    end
  end

  def mis_torneos
    @torneos = Torneo.all.where('gamer_id = :gamer_id ', gamer_id: current_gamer.id).order(cierre_inscripcion: :asc)
  end

  def iniciar_torneo
    @torneo = Torneo.find(params[:id_torneo])
    @torneo.generar_encuentros if current_gamer == @torneo.gamer
  end

  def comenzar
    @torneo = Torneo.find_by(id: params[:id_torneo], gamer_id: current_gamer.id)
    @torneo.estado = params['estado']
    respond_to do |format|
      if @torneo.save
        @torneo.generar_encuentros
        format.html { render action: 'iniciar_torneo', notice: 'Torneo was successfully updated.' }
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
    torneo = Torneo.find_by(id: params[:id_torneo], gamer_id: current_gamer.id, estado: "Creado")
    gamers_array = params['gamers']

    gamers_array.each_line do | gamer_temporal_nick |
      gamer_temporal_nick = gamer_temporal_nick.strip
      gamer = Gamer.new(correo: gamer_temporal_nick + '@temporal.com' , apellidos: gamer_temporal_nick)
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_torneo
    @torneo = Torneo.find(params[:id])
  end



  # Never trust parameters from the scary internet, only allow the white list through.
  def torneo_params
    params.require(:torneo).permit(:titulo, :urlstreeming, :vacantes, :cierre_inscripcion, :post_detalle_torneo,:periodo_confirmacion_en_minutos, :tipo_generacion, :estado, :juego)
  end
end
