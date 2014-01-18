class RondasController < ApplicationController
  before_action :set_ronda, only: [:show, :edit, :update, :destroy]

  # GET /rondas
  # GET /rondas.json
  def index
    @rondas = Ronda.all
  end

  # GET /rondas/1
  # GET /rondas/1.json
  def show
  end

  # GET /rondas/new
  def new
    @ronda = Ronda.new
  end

  # GET /rondas/1/edit
  def edit
  end

  # POST /rondas
  # POST /rondas.json
  def create
    @ronda = Ronda.new(ronda_params)

    respond_to do |format|
      if @ronda.save
        format.html { redirect_to @ronda, notice: 'Ronda was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ronda }
      else
        format.html { render action: 'new' }
        format.json { render json: @ronda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rondas/1
  # PATCH/PUT /rondas/1.json
  def update
    respond_to do |format|
      if @ronda.update(ronda_params)
        format.html { redirect_to @ronda, notice: 'Ronda was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ronda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rondas/1
  # DELETE /rondas/1.json
  def destroy
    @ronda.destroy
    respond_to do |format|
      format.html { redirect_to rondas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ronda
      @ronda = Ronda.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ronda_params
      params.require(:ronda).permit(:numero, :inicio_fecha, :inicio_tiempo, :modo_ganar, :torneo_id)
    end
end
