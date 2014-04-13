class TorneosController < ApplicationController
  before_action :set_torneo, only: [:preparar,:show, :edit, :update, :destroy]
  require_relative '../../app/helpers/torneos_helper'

  # GET /torneos GET /torneos.json
  def index
    @torneos = Torneo.all.order(:cierre_inscripcion_fecha,:cierre_inscripcion_tiempo).limit(20).where("date(cierre_inscripcion_fecha) > date(:fecha_actual) or ( cierre_inscripcion_tiempo > time :hora_actual and date(cierre_inscripcion_fecha) = date(:fecha_actual) )",{fecha_actual: Time.new.strftime("%F"), hora_actual:Time.new.strftime("%T")})
  end

  # GET /torneos/1
  # GET /torneos/1.json
  def show
  end
attr_writer :attr_names
  # GET /torneos/new
  def new
    @torneo = Torneo.new
    @torneo.vacantes=8
    @torneo.inicio_torneo_fecha = (Time.new + (60 * 60 * 2)).to_date
    @torneo.inicio_torneo_tiempo = Time.new + (60 * 60 * 2)

    @torneo.cierre_inscripcion_fecha = (Time.new + ((60 * 60 * 2) - (45 * 60) )).to_date
    @torneo.cierre_inscripcion_tiempo = Time.new + ((60 * 60 * 2) - (45 * 60) )
  end

  def preparar
    if @torneo.estado == 'Iniciado' then
      respond_to do |format|
        format.html { render action: 'desarrollo', notice: 'Torneo was successfully updated.' }      
      end
      return
    end

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

    flag_existe_error=false

    

    vacantes = torneo_params[:vacantes]

    rondas_contador = TorneosHelper.obtener_rondas_por_vacantes(vacantes.to_i)

    for i in 1..rondas_contador
      if params["ronda"+i.to_s] != nil
        ronda=Ronda.new(params["ronda"+i.to_s].permit(:numero,:inicio_fecha,:inicio_tiempo,:modo_ganar))

        if ronda.inicio_fecha == nil || ronda.inicio_tiempo == nil then
          @torneo.errors.add(:inicio_torneo,"las fechas de las rondas no pueden estar vacias")
          flag_existe_error=true
        end

        if i > 1 then           
          @torneo.rondas.each do | ronda_previa|
            if ronda_previa.numero == (i - 1) then
              if (ronda.inicio_ronda - ronda_previa.inicio_ronda) <= ( 60 * 60) then
                  @torneo.errors.add(:inicio_torneo,", la fecha de inicio de la ronda " + ronda.numero.to_s + " debe ser mayor por una hora a la ronda " + ronda_previa.numero.to_s)                  
                  flag_existe_error=true
              end
              break
            end
            
          end
        end

        @torneo.rondas << ronda
      end
    end

                  

    id_juego = params["juego"].permit(:id)[:id]
    juego = Juego.new
    juego.id = id_juego
    @torneo.juego = juego

    if ((@torneo.inicio_torneo.to_i - Time.new.to_i) < (60 * 60) ) then

        @torneo.errors.add(:inicio_torneo,"debe ser mayor a 1 hora desde la fecha actual")
        flag_existe_error=true
        return
    end

    respond_to do |format|
      if flag_existe_error || @torneo.save
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

      #indice_posiciones=0
      #contador_encuentros=1
      #@torneo.inscripcions.order(:posicion_inicial).each do | inscripcion_gamer | 
      #  encuentro = Encuentro.new
      #  encuentro.estado="No Iniciado"        
      #  encuentro.gamer_a=inscripcion_gamer
      #  next
      #  encuentro.gamer_b=inscripcion_gamer
      #  encuentro.posicion_en_ronda=contador_encuentros
      #  encuentro.save
      #  contador_encuentros=contador_encuentros+1
      #end      

      respond_to do |format|
        if @torneo.update(torneo_params)
          format.html { render action: 'desarrollo', notice: 'Torneo was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @torneo.errors, status: :unprocessable_entity }
        end
      end
      return
    end

    
    #obtener_posicion_de_ronda_por_ranking

    @torneo.inscripcions.order(:id).limit(@torneo.vacantes).each do | inscripcion | 
      inscripcion.peso_participacion =params["inscripcion"+inscripcion.id.to_s].permit(:peso_participacion)[:peso_participacion]
      inscripcion.save
    end
    
    if torneo_params[:tipo_generacion] == 'A' then
      posiciones=TorneosHelper.obtener_posicion_de_ronda_aleatoriamente(@torneo.vacantes,1)
    elsif torneo_params[:tipo_generacion] == 'M' then
      posiciones=TorneosHelper.obtener_posicion_de_ronda_manual(@torneo.vacantes,1)      
    else
      posiciones=TorneosHelper.obtener_posicion_de_ronda_por_ranking(@torneo.vacantes,1)
    end
        
    indice_posiciones=0
    @torneo.inscripcions.order(:peso_participacion).each do | inscripcion | 
      inscripcion.posicion_inicial=posiciones[indice_posiciones]
      inscripcion.save
      indice_posiciones=indice_posiciones+1
    end

    for i in  (indice_posiciones+1)..@torneo.vacantes 
      inscripcion = Inscripcion.new
      inscripcion.posicion_inicial=posiciones[indice_posiciones]
      inscripcion.estado_confirmacion='C'
      inscripcion.fecha_inscripcion=Time.new
      inscripcion.peso_participacion=i
      inscripcion.gamer = Gamer.find(-1000)
      @torneo.inscripcions << inscripcion
      indice_posiciones=indice_posiciones+1
    end

    ronda_inicial=@torneo.rondas.where(numero: 1)
   

    respond_to do |format|
      if @torneo.update(torneo_params)
        format.html { render action: 'simular_llaves', notice: 'Torneo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @torneo.errors, status: :unprocessable_entity }
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
      params.require(:torneo).permit(:titulo, :paginaweb, :vacantes, :cierre_inscripcion_fecha, :cierre_inscripcion_tiempo, :inicio_torneo_fecha, :inicio_torneo_tiempo,:tipo_generacion,:estado,:juego)
    end
end
