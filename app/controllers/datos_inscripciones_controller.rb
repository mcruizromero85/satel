 class DatosInscripcionesController < ApplicationController
  before_action :set_gamer, only: [:show, :edit, :update, :destroy]

  # GET /gamers
  # GET /gamers.json
  def index
    @gamers = DatosInscripcion.all
  end

  def new
  	@datos_inscripcion = DatosInscripcion.new
  end
 

end
