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
  end

  attr_writer :attr_names
  # GET /torneos/new
  def new
    @torneo = Torneo.new
    @torneo.inicializar_valores
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
    @torneo.juego = Juego.new(id: params['juego'].permit(:id)[:id])
    @torneo.estado = 'Pendiente'
    respond_to do |format|
      if @torneo.save
        format.html { render action: 'datos_inscripcion' }
        format.json { render action: 'show', status: :created, location: @torneo }
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
    @torneo = Torneo.find(params[:id_torneo])
    @torneo.generar_encuentros if current_gamer == @torneo.gamer
  end

  def comenzar
    @torneo = Torneo.find(params[:id_torneo])
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

  # PATCH/PUT /torneos/1
  # PATCH/PUT /torneos/1.json
  def update
    @torneo = Torneo.find(params[:id])
    @torneo.estado = 'Creado'
    @torneo.rondas.destroy_all
    TorneosHelper.obtener_rondas_por_vacantes(@torneo.vacantes).times do | i |
      @torneo.agregar_ronda(Ronda.new(params['ronda' + (i + 1).to_s].permit(:numero, :inicio_fecha, :inicio_tiempo, :modo_ganar)))
    end
    contador = 0
    loop do
      break if params['datos_inscripcion' + contador.to_s].nil?
      @torneo.agregar_dato_inscripcion(DatosInscripcion.new(params['datos_inscripcion' + contador.to_s].permit(:nombre)))
      contador += 1
    end

    respond_to do |format|
      if @torneo.save
        format.html { redirect_to action: 'show', notice: 'Torneo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @torneo }
      else
        format.html { render action: 'datos_inscripcion' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_torneo
    @torneo = Torneo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def torneo_params
    params.require(:torneo).permit(:titulo, :paginaweb, :vacantes, :cierre_inscripcion, :periodo_confirmacion_en_minutos, :tipo_generacion, :estado, :juego)
  end
end
