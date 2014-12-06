class JuegosController < ApplicationController
  before_action :set_juego, only: [:show, :edit, :update, :destroy]

  # GET /juegos
  # GET /juegos.json
  def index
    @juegos = Juego.all
  end

  # GET /juegos/1
  # GET /juegos/1.json
  def show
  end

  # GET /juegos/new
  def new
    @juego = Juego.new
  end

  # GET /juegos/1/edit
  def edit
  end

  # POST /juegos
  # POST /juegos.json
  def create
    @juego = Juego.new(juego_params)

    respond_to do |format|
      if @juego.save
        format.html { redirect_to @juego, notice: 'Juego was successfully created.' }
        format.json { render action: 'show', status: :created, location: @juego }
      else
        format.html { render action: 'new' }
        format.json { render json: @juego.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /juegos/1
  # PATCH/PUT /juegos/1.json
  def update
    respond_to do |format|
      if @juego.update(juego_params)
        format.html { redirect_to @juego, notice: 'Juego was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @juego.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /juegos/1
  # DELETE /juegos/1.json
  def destroy
    @juego.destroy
    respond_to do |format|
      format.html { redirect_to juegos_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_juego
    @juego = Juego.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def juego_params
    params.require(:juego).permit(:nombre, :descripcion, :asociado_id)
  end
end
