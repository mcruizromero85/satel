class InscripcionesController < ApplicationController
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new]

  # GET /inscripciones
  # GET /inscripciones.json
  def index
    @inscripciones = Inscripcion.where(torneo_id:  params[:id_torneo]).order(:created_at)
    @mensaje_inscripcion = params[:mensaje_inscripcion]
  end

  # GET /inscripciones/1
  # GET /inscripciones/1.json
  def show
  end

  # GET /inscripciones/new
  def new
    @torneo = Torneo.find(params[:id_torneo])
    @inscripcion = Inscripcion.new
  end

  # GET /inscripciones/1/edit
  def edit
  end

  # POST /inscripciones
  # POST /inscripciones.json
  def create
    @inscripcion = Inscripcion.new
    @inscripcion.gamer = current_gamer
    @inscripcion.torneo = Torneo.find(params[:id_torneo])

    respond_to do |format|
      if @inscripcion.save
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html { render action: 'new' }
      end
    end
  end

  def confirmar
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    @inscripcion.estado = 'Confirmado'

    respond_to do |format|
      if @inscripcion.save
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html { render action: 'new' }
      end
    end
  end
end
