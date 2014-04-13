class InscripcionsController < ApplicationController
  before_action :set_inscripcion, only: [:show, :edit, :update, :destroy]

  # GET /inscripcions
  # GET /inscripcions.json
  def index
    @inscripcions = Inscripcion.all
  end

  # GET /inscripcions/1
  # GET /inscripcions/1.json
  def show
  end

  # GET /inscripcions/new
  def new
    @inscripcion = Inscripcion.new
  end

  # GET /inscripcions/1/edit
  def edit
  end

  # POST /inscripcions
  # POST /inscripcions.json
  def create

    print "numero inscripciones: " + params["inscripcion"][:numero_inscripciones].to_s
    
    for i in 1..params["inscripcion"][:numero_inscripciones].to_i
      inscripcion = Inscripcion.new
      inscripcion.fecha_inscripcion=Time.new.to_date
      inscripcion.hora_inscripcion=Time.new
      inscripcion.estado_confirmacion='C'
      inscripcion.peso_participacion=0
      inscripcion.posicion_inicial=0
      inscripcion.gamer_id=i
      inscripcion.torneo_id=params["inscripcion"][:torneo_id].to_i
      inscripcion.save
    end
    

    respond_to do |format|
        format.html { redirect_to "/", notice: 'Inscripcion was successfully created.' }
    end
  end

  # PATCH/PUT /inscripcions/1
  # PATCH/PUT /inscripcions/1.json
  def update
    respond_to do |format|
      if @inscripcion.update(inscripcion_params)
        format.html { redirect_to @inscripcion, notice: 'Inscripcion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inscripcion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inscripcions/1
  # DELETE /inscripcions/1.json
  def destroy
    @inscripcion.destroy
    respond_to do |format|
      format.html { redirect_to inscripcions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inscripcion
      @inscripcion = Inscripcion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inscripcion_params
      params.require(:inscripcion).permit(:fecha_inscripcion, :hora_inscripcion, :estado_confirmacion, :peso_participacion, :gamer_id, :torneo_id, :numero_inscripciones)
    end
end
