class TorneosController < ApplicationController
  require_relative '../../app/helpers/torneos_helper'

  before_action :set_torneo, only: [:preparar,:show, :edit, :update, :destroy]
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new,:mis_torneos]

  # GET /torneos GET /torneos.json
  def index 
    if current_gamer != nil 

      @torneos_iniciados = Torneo.obtener_torneos_iniciados(current_gamer)
      if @torneos_iniciados.size > 0 
        ids_torneos_inscritos_y_confirmados=@torneos_iniciados.pluck(:id)
      else
        ids_torneos_inscritos_y_confirmados=[-1]
      end

      @torneos_confirmados = Torneo.obtener_torneos_ya_confirmados(current_gamer)

      if @torneos_confirmados.size > 0 
        ids_torneos_inscritos_y_confirmados.concat(@torneos_confirmados.pluck(:id))
      end

      @torneos_inscritos = Torneo.obtener_torneos_ya_inscrito(current_gamer)
      ids_torneos_inscritos_y_confirmados.concat(@torneos_inscritos.pluck(:id))
    else
      @torneos_iniciados= Array.new
    	@torneos_confirmados= Array.new
    	@torneos_inscritos=Array.new	
      ids_torneos_inscritos_y_confirmados=[-1]
    end
    @torneos=Torneo.obtener_torneos_disponibles_para_inscribir(ids_torneos_inscritos_y_confirmados)    
  end

  # GET /torneos/1
  # GET /torneos/1.json
  def show
  end

attr_writer :attr_names
  # GET /torneos/new
  def new
    @torneo=Torneo.new
    @torneo.inicializar_valores_por_defecto
  end

  # GET /torneos/1/edit
  def edit
  end

  # POST /torneos
  # POST /torneos.json
  def create
    @torneo = Torneo.new(torneo_params)
    @torneo.fecha_y_hora_inscripcion(params['cierre_inscripcion_fecha'],params['cierre_inscripcion_hora'])
    @torneo.gamer = current_gamer
    @torneo.juego = Juego.new(id: params["juego"].permit(:id)[:id])

    for i in 1..TorneosHelper.obtener_rondas_por_vacantes(@torneo.vacantes)
        @torneo.agregar_ronda(Ronda.new(params["ronda"+i.to_s].permit(:numero,:inicio_fecha,:inicio_tiempo,:modo_ganar)))
    end
    
    respond_to do |format|
      if @torneo.save then
        format.html { redirect_to @torneo, notice: 'Torneo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @torneo }
      else
        format.html { render action: 'new' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
      end
    end
  end

  def mis_torneos
    @torneos=Torneo.all.where("gamer_id = :gamer_id ",{gamer_id: current_gamer.id }).order(cierre_inscripcion: :desc) 
  end

  def iniciar_torneo
     @torneo = Torneo.find(params[:id_torneo])
     @torneo.generar_encuentros
  end

  # PATCH/PUT /torneos/1
  # PATCH/PUT /torneos/1.json
  def update
      @torneo.estado="Iniciado"
      respond_to do |format|  
        if @torneo.save
          @torneo.generar_encuentros
          format.html { render action: 'iniciar_torneo', notice: 'Torneo was successfully updated.' }        
        else
          @torneo.estado="Creado"
          format.html { render action: 'iniciar_torneo', notice: 'Error' }   
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
      params.require(:torneo).permit(:titulo, :paginaweb, :vacantes, :cierre_inscripcion, :periodo_confirmacion_en_minutos,:tipo_generacion,:estado,:juego)
    end
end
