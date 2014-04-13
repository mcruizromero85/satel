class AsociadosController < ApplicationController
  before_action :set_asociado, only: [:show, :edit, :update, :destroy]

  # GET /asociados
  # GET /asociados.json
  def index
    @asociados = Asociado.all
  end

  # GET /asociados/1
  # GET /asociados/1.json
  def show
  end

  # GET /asociados/new
  def new
    @asociado = Asociado.new
  end

  # GET /asociados/1/edit
  def edit
  end

  # POST /asociados
  # POST /asociados.json
  def create
    @asociado = Asociado.new(asociado_params)

    respond_to do |format|
      if @asociado.save
        format.html { redirect_to @asociado, notice: 'Asociado was successfully created.' }
        format.json { render action: 'show', status: :created, location: @asociado }
      else
        format.html { render action: 'new' }
        format.json { render json: @asociado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asociados/1
  # PATCH/PUT /asociados/1.json
  def update
    respond_to do |format|
      if @asociado.update(asociado_params)
        format.html { redirect_to @asociado, notice: 'Asociado was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @asociado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asociados/1
  # DELETE /asociados/1.json
  def destroy
    @asociado.destroy
    respond_to do |format|
      format.html { redirect_to asociados_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asociado
      @asociado = Asociado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asociado_params
      params.require(:asociado).permit(:nombre, :descripcion, :juego_id)
    end
end
