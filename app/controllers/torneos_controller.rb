class TorneosController < ApplicationController
  require_relative '../../app/helpers/torneos_helper'

  before_action :set_torneo, only: [:preparar,:show, :edit, :update, :destroy]
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new,:mis_torneos]

  def mis_torneos
    @torneos=Torneo.all.where("gamer_id = :gamer_id ",{gamer_id: current_gamer.id }).order(cierre_inscripcion_fecha: :desc,cierre_inscripcion_tiempo: :desc) 
  end

  def iniciar_torneo
     @torneo = Torneo.find(params[:id_torneo])
     @torneo.generar_encuentros
     session[:array_encuentros_para_guardar_llaves] = @torneo.array_encuentros_para_guardar_llaves

  end

  # GET /torneos GET /torneos.json
  def index 
    if current_gamer != nil 
      @torneos_confirmados = Torneo.obtener_torneos_ya_confirmados(current_gamer)

      if @torneos_confirmados.size > 0 
        ids_torneos_inscritos_y_confirmados=@torneos_confirmados.pluck(:id)
      else
        ids_torneos_inscritos_y_confirmados=[-1]
      end

      @torneos_inscritos = Torneo.obtener_torneos_ya_inscrito(current_gamer)
      ids_torneos_inscritos_y_confirmados.concat(@torneos_inscritos.pluck(:id))
    else
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
    @torneo.vacantes=8
    @torneo.cierre_inscripcion_fecha = (Time.new + (60 * 60 * 0.5)).to_date
    @torneo.cierre_inscripcion_tiempo = Time.new + ((60 * 60 * 0.5))            

      numero_de_rondas_totales=TorneosHelper.obtener_rondas_por_vacantes(@torneo.vacantes)

      for i in 1..numero_de_rondas_totales
          ronda=Ronda.new
          ronda.numero = i
          ronda.inicio_fecha=Time.new + (60 * 60 * ronda.numero)
          ronda.inicio_tiempo=Time.new + (60 * 60 * ronda.numero)
          if i == numero_de_rondas_totales then
            ronda.modo_ganar = 5
          else
            ronda.modo_ganar = 1  
          end
          @torneo.rondas << ronda
      end
  end

  # GET /torneos/1/edit
  def edit
  end

  # POST /torneos
  # POST /torneos.json
  def create
    @torneo = Torneo.new(torneo_params)
    @torneo.fecha_y_hora_inscripcion(torneo_params['cierre_inscripcion_fecha'],torneo_params['cierre_inscripcion_tiempo'])

    rondas_contador = TorneosHelper.obtener_rondas_por_vacantes(@torneo.vacantes)

    for i in 1..rondas_contador
      if params["ronda"+i.to_s] != nil
        ronda=Ronda.new(params["ronda"+i.to_s].permit(:numero,:inicio_fecha,:inicio_tiempo,:modo_ganar))
      end
      if ronda.valid?
        @torneo.rondas << ronda
      end
    end
   
    id_juego = params["juego"].permit(:id)[:id]
    juego = Juego.new
    juego.id = id_juego
    @torneo.juego = juego
    @torneo.gamer = current_gamer
    
    respond_to do |format|
      if @torneo.registrar then
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
    if torneo_params[:estado] == 'Iniciado' then      
      respond_to do |format|        
        @torneo.estado=torneo_params[:estado]
        if @torneo.valid? 

          array_encuentros_para_guardar_llaves = session[:array_encuentros_para_guardar_llaves]        
          contador_posicion_en_ronda=1
          array_encuentros_para_guardar_llaves.each do | array_encuentro | 
            gamera = Gamer.new
            gamera.id = array_encuentro[0]

            gamerb = Gamer.new
            gamerb.id = array_encuentro[1]

            encuentro = Encuentro.new
            encuentro.gamera=gamera
            encuentro.gamerb=gamerb
            encuentro.posicion_en_ronda=contador_posicion_en_ronda
            encuentro.ronda=@torneo.rondas.first
            encuentro.save
            contador_posicion_en_ronda=contador_posicion_en_ronda+1
          end

          @torneo.save
          @torneo.generar_encuentros
          
          format.html { render action: 'iniciar_torneo', notice: 'Torneo was successfully updated.' }        
        else
          @torneo.estado="Creado"
          @torneo.generar_encuentros
          session[:array_encuentros_para_guardar_llaves] = @torneo.array_encuentros_para_guardar_llaves
          format.html { render action: 'iniciar_torneo', notice: 'Error' }   
        end     
      end
    else

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
