class DatosInscripcionRegistradosController < ApplicationController
  before_action :set_datos_inscripcion_registrado, only: [:show, :edit, :update, :destroy]

  # GET /datos_inscripcion_registrados
  # GET /datos_inscripcion_registrados.json
  def index
    @datos_inscripcion_registrados = DatosInscripcionRegistrado.all
  end

  # GET /datos_inscripcion_registrados/1
  # GET /datos_inscripcion_registrados/1.json
  def show
  end

  # GET /datos_inscripcion_registrados/new
  def new
    @datos_inscripcion_registrado = DatosInscripcionRegistrado.new
  end

  # GET /datos_inscripcion_registrados/1/edit
  def edit
  end

  # POST /datos_inscripcion_registrados
  # POST /datos_inscripcion_registrados.json
  def create
    @datos_inscripcion_registrado = DatosInscripcionRegistrado.new(datos_inscripcion_registrado_params)

    respond_to do |format|
      if @datos_inscripcion_registrado.save
        format.html { redirect_to @datos_inscripcion_registrado, notice: 'Datos inscripcion registrado was successfully created.' }
        format.json { render action: 'show', status: :created, location: @datos_inscripcion_registrado }
      else
        format.html { render action: 'new' }
        format.json { render json: @datos_inscripcion_registrado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datos_inscripcion_registrados/1
  # PATCH/PUT /datos_inscripcion_registrados/1.json
  def update
    respond_to do |format|
      if @datos_inscripcion_registrado.update(datos_inscripcion_registrado_params)
        format.html { redirect_to @datos_inscripcion_registrado, notice: 'Datos inscripcion registrado was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @datos_inscripcion_registrado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datos_inscripcion_registrados/1
  # DELETE /datos_inscripcion_registrados/1.json
  def destroy
    @datos_inscripcion_registrado.destroy
    respond_to do |format|
      format.html { redirect_to datos_inscripcion_registrados_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datos_inscripcion_registrado
      @datos_inscripcion_registrado = DatosInscripcionRegistrado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datos_inscripcion_registrado_params
      params.require(:datos_inscripcion_registrado).permit(:datos_inscripcion_id, :valor, :inscripcion_id)
    end
end
