class HotsFormulariosController < ApplicationController
  before_action :set_hots_formulario, only: [:show, :edit, :update, :destroy]

  # GET /hots_formularios
  # GET /hots_formularios.json
  def index
    @hots_formularios = HotsFormulario.all
  end

  # GET /hots_formularios/1
  # GET /hots_formularios/1.json
  def show
  end

  # GET /hots_formularios/new
  def new
    @hots_formulario = HotsFormulario.new
  end

  # GET /hots_formularios/1/edit
  def edit
  end

  # POST /hots_formularios
  # POST /hots_formularios.json
  def create
    @hots_formulario = HotsFormulario.new(hots_formulario_params)

    respond_to do |format|
      if @hots_formulario.save
        format.html { redirect_to @hots_formulario, notice: 'Hots formulario was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hots_formulario }
      else
        format.html { render action: 'new' }
        format.json { render json: @hots_formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hots_formularios/1
  # PATCH/PUT /hots_formularios/1.json
  def update
    respond_to do |format|
      if @hots_formulario.update(hots_formulario_params)
        format.html { redirect_to @hots_formulario, notice: 'Hots formulario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hots_formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hots_formularios/1
  # DELETE /hots_formularios/1.json
  def destroy
    @hots_formulario.destroy
    respond_to do |format|
      format.html { redirect_to hots_formularios_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hots_formulario
      @hots_formulario = HotsFormulario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hots_formulario_params
      params.require(:hots_formulario).permit(:capitan_nick, :nombre_equipo, :titular_numero1,:titular_numero2,:titular_numero3,:titular_numero4,:suplente_numero1,:suplente_numero2)
    end
end
