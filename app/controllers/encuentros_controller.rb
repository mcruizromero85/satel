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
  end

  # PATCH/PUT /encuentros/1
  # PATCH/PUT /encuentros/1.json
  def update
    @encuentro.gamer_ganador = Gamer.new(id: params['encuentro_gamer_ganador_id'])

    respond_to do |format|
      if @encuentro.save
        format.html { redirect_to action: 'iniciar_torneo', controller: 'torneos', id_torneo: @encuentro.ronda.torneo.id }
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

  def set_encuentro
    @encuentro = Encuentro.find(params[:id])
  end
end
