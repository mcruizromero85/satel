class Prueba2sController < ApplicationController
  before_action :set_prueba2, only: [:show, :edit, :update, :destroy]

  # GET /prueba2s
  # GET /prueba2s.json
  def index
    @prueba2s = Prueba2.all
  end

  # GET /prueba2s/1
  # GET /prueba2s/1.json
  def show
  end

  # GET /prueba2s/new
  def new
    @prueba2 = Prueba2.new
  end

  # GET /prueba2s/1/edit
  def edit
  end

  # POST /prueba2s
  # POST /prueba2s.json
  def create
    @prueba2 = Prueba2.new(prueba2_params)

    respond_to do |format|
      if @prueba2.save
        format.html { redirect_to @prueba2, notice: 'Prueba2 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prueba2 }
      else
        format.html { render action: 'new' }
        format.json { render json: @prueba2.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prueba2s/1
  # PATCH/PUT /prueba2s/1.json
  def update
    respond_to do |format|
      if @prueba2.update(prueba2_params)
        format.html { redirect_to @prueba2, notice: 'Prueba2 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prueba2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prueba2s/1
  # DELETE /prueba2s/1.json
  def destroy
    @prueba2.destroy
    respond_to do |format|
      format.html { redirect_to prueba2s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prueba2
      @prueba2 = Prueba2.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prueba2_params
      params.require(:prueba2).permit(:estado)
    end
end
