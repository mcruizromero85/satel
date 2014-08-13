class TorneosController < ApplicationController
  require_relative '../../app/helpers/torneos_helper'
  require_relative '../../app/services/torneos_service'

  before_action :set_torneo, only: [:preparar,:show, :edit, :update, :destroy]
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new]
  
  def revisa_si_existe_gamer_en_sesion
    if current_gamer == nil then
      session[:last_url_pre_login] = '/torneos/new'
      redirect_to '/auth/facebook'
    end
  end

  # GET /torneos GET /torneos.json
  def index

    @torneos_view=TorneoView.new
    @torneos_view.listado_torneos=TorneosService.obtener_torneos_para_portada      

  end

  # GET /torneos/1
  # GET /torneos/1.json
  def show
    @torneo_view=TorneoView.new    
    @torneo_view.torneo_detallado=@torneo
  end

attr_writer :attr_names
  # GET /torneos/new
  def new
    @torneo_view=TorneoView.new
    @torneo_view.inicializar_datos_de_torneo_nuevo
    @torneo_view.lista_juegos=JuegosService.obtener_juegos
    
  end

  def preparar
    if @torneo.estado == 'Iniciado' then
      respond_to do |format|
        @torneo_view=TorneoView.new    
        @torneo_view.torneo_detallado=@torneo
        format.html { render action: 'desarrollo', notice: 'Torneo was successfully updated.' }      
      end
    end
    @torneo_view=TorneoView.new    
    @torneo_view.torneo_detallado=@torneo

  end

  def simular_llaves

  end

  # GET /torneos/1/edit
  def edit
  end

  # POST /torneos
  # POST /torneos.json
  def create
    @torneo = Torneo.new(torneo_params)
    
    respond_to do |format|
      if TorneosService.guardar_torneo(@torneo,params)
        format.html { redirect_to @torneo, notice: 'Torneo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @torneo }
      else
        @torneo_view=TorneoView.new
        @torneo_view.data_inicial_para_registro=@torneo
        @torneo_view.lista_juegos=JuegosService.obtener_juegos
        format.html { render action: 'new' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /torneos/1
  # PATCH/PUT /torneos/1.json
  def update

    if torneo_params[:estado] == 'Iniciado' then
      @torneo.estado= torneo_params[:estado]
      respond_to do |format|
        if TorneosService.iniciar_torneo(@torneo)
          @torneo_view=TorneoView.new    
          @torneo_view.torneo_detallado=@torneo
          format.html { render action: 'desarrollo', notice: 'Torneo was successfully updated.' }
        else
          format.html { render action: 'edit' }
        end
      end
    else
      @torneo.tipo_generacion = torneo_params[:tipo_generacion]
      respond_to do |format|
        if TorneosService.generar_estructura_llaves(@torneo,params) then
          @torneo_view=TorneoView.new    
          @torneo_view.torneo_detallado=@torneo
          format.html { render action: 'simular_llaves', notice: 'Torneo was successfully updated.' }         
        else
          format.html { render action: 'edit' }
        end
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
      params.require(:torneo).permit(:titulo, :paginaweb, :vacantes, :cierre_inscripcion_fecha, :cierre_inscripcion_tiempo,:periodo_confirmacion_en_minutos,:tipo_generacion,:estado,:juego)
    end
end
