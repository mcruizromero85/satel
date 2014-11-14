class EncuentrosController < ApplicationController
  before_action :set_encuentro, only: [:show, :edit, :update, :destroy]

  # GET /encuentros
  # GET /encuentros.json
  def index
    @encuentros = Encuentro.all
  end

  # GET /encuentros/1
  # GET /encuentros/1.json
  def show
  end

  # GET /encuentros/new
  def new
    @encuentro = Encuentro.new
  end

  # GET /encuentros/1/edit
  def edit
  end

  # POST /encuentros
  # POST /encuentros.json
  def create
    @encuentro = Encuentro.new(encuentro_params)

    respond_to do |format|
      if @encuentro.save
        format.html { redirect_to @encuentro, notice: 'Encuentro was successfully created.' }
        format.json { render action: 'show', status: :created, location: @encuentro }
      else
        format.html { render action: 'new' }
        format.json { render json: @encuentro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encuentros/1
  # PATCH/PUT /encuentros/1.json
  def update

    @encuentro.gamer_ganador=Gamer.new(id: params['encuentro_gamer_ganador_id'])

    respond_to do |format|
      if @encuentro.save
        format.html { redirect_to :action => 'iniciar_torneo', :controller=>"torneos", :id_torneo => @encuentro.ronda.torneo.id }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @encuentro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encuentros/1
  # DELETE /encuentros/1.json
  def destroy
    @encuentro.destroy
    respond_to do |format|
      format.html { redirect_to encuentros_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encuentro
      @encuentro = Encuentro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encuentro_params
      params.require(:encuentro).permit(:gamera_id, :gamerb_id, :posicion_en_ronda, :id_ronda, :flag_ganador, :descripcion, :encuentro_anterior_a_id, :encuentro_anterior_b_id)
    end
end
