class InscripcionesController < ApplicationController
  before_action :revisa_si_existe_gamer_en_sesion, only: [:show_by_tournament, :new, :create, :index]
  
  before_filter :set_headers 

  # GET /inscripciones
  # GET /inscripciones.json
  def index
    @inscripciones = Inscripcion.where(torneo_id:  params[:id_torneo]).order(:created_at)
    @torneo = Torneo.find(params[:id_torneo])
    @mensaje_inscripcion = params[:mensaje_inscripcion]
  end

  # GET /inscripciones/1
  # GET /inscripciones/1.json
  def show_by_tournament
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    respond_to do |format|
      if !@inscripcion.nil?
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo]}
        format.json { render json: @inscripcion, status: :ok }
      else        
        format.json { render json: params[:id_torneo].to_json , status: :not_found }
      end
    end
  end

  # GET /inscripciones/new
  def new
    @torneo = Torneo.find(params[:id_torneo])
    @inscripcion = Inscripcion.new
    @mensaje_inscripcion_error = params[:mensaje_inscripcion_error] unless params[:mensaje_inscripcion_error].nil?
  end

  # GET /inscripciones/1/edit
  def edit
  end

  # POST /inscripciones
  # POST /inscripciones.json
  def create
    @torneo = Torneo.new(torneo_params)
    if @torneo.estado != 'Creado'
      @inscripcion = Inscripcion.new(gamer: current_gamer, torneo: @torneo_tmp)
      respond_to do |format|
        if @inscripcion.inscribir
          format.html { render action: 'index' }
          format.json { render json: @inscripcion, status: :created }
        else          
          format.html { render action: 'new' }
          format.json { render json: @inscripcion.errors.full_messages.to_json , status: :not_acceptable }
        end
      end

    else

      respond_to do |format|
        @inscripcion = Inscripcion.new(gamer: current_gamer, torneo: @torneo_tmp)
        @torneo = Torneo.find(@inscripcion.torneo.id)
        format.html { render action: 'new' }
        format.json { render json: @inscripcion.errors.full_messages.to_json , status: :not_acceptable }
      end

    end

  end

  def confirmar
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    solo_confirmar
  end
  # DELETE /gamers/1
  # DELETE /gamers/1.json
  def destroy
    inscripcion = Inscripcion.find(params[:id])
    inscripcion.destroy if current_gamer.id == inscripcion.gamer.id || current_gamer.id == inscripcion.torneo.gamer.id
    respond_to do |format|
      format.html { redirect_to action: 'index', id_torneo: inscripcion.torneo.id }
      format.json { head :no_content }
    end
  end

  def options
    set_headers
    render :text => '', :content_type => 'text/plain'
  end

  private


  # Set CORS
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'Etag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*, x-requested-with, Content-Type, If-Modified-Since, If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end

  def solo_confirmar
    respond_to do |format|
      if @inscripcion.confirmar
        format.html { redirect_to action: 'iniciar_torneo', controller: 'torneos', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
        format.json { render json: @inscripcion, status: :created }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html { render action: 'new' }
        format.json { render json: @inscripcion.errors.full_messages.to_json , status: :not_acceptable }
      end
    end
  end

  def confirmar_y_cerrar_pago
    detalle_pago_inscripcion = DetallePagoInscripcion.find_by(torneo_id: params[:id_torneo])
    unless es_retornado_de_pasarela_de_pago
      detalle_pago_inscripcion.crear_pago(@torneo.id, @torneo.titulo)
      respond_to do |format|
        format.html { redirect_to detalle_pago_inscripcion.url_de_pago }
      end
      return
    end

    respond_to do |format|
      if detalle_pago_inscripcion.cerrar_pago(params[:paymentId], params[:PayerID]) && @inscripcion.confirmar(detalle_pago_inscripcion.id_transaccion)
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
      else
        @inscripcion.destroy
        if !detalle_pago_inscripcion.mensaje_error_paypal.nil?
          mensaje_inscripcion_error = detalle_pago_inscripcion.mensaje_error_paypal
        else
          mensaje_inscripcion_error = 'Error interno contacta, con el administrador: mcruizromero85@gmail.com'
        end
        format.html { redirect_to action: 'new', id_torneo: params[:id_torneo], mensaje_inscripcion_error: mensaje_inscripcion_error }
      end
    end
  end

  def inscribir
    respond_to do |format|
      if @inscripcion.inscribir
        @torneo = Torneo.find(@inscripcion.torneo.id)
        mensaje_inscripcion = 'Inscripción realizada con éxito'
        format.html { redirect_to action: 'index' }
        format.json { render json: @inscripcion, status: :created }
      else
        @torneo = Torneo.find(@inscripcion.torneo.id)
        @mensaje_inscripcion = @inscripcion.mensaje_inscripcion        
        format.html { render action: 'new', id_torneo: params[:id_torneo] }        
        format.json { render json: @inscripcion.errors.full_messages.to_json , status: :not_acceptable }
      end
    end
  end

  def inscribir_y_cobrar
    detalle_pago_inscripcion = DetallePagoInscripcion.find_by(torneo_id: params[:id_torneo])
    respond_to do |format|
      if @inscripcion.inscribir && detalle_pago_inscripcion.crear_pago(@torneo.id, @torneo.titulo)
        format.html { redirect_to detalle_pago_inscripcion.url_de_pago }
      else
        if !detalle_pago_inscripcion.mensaje_error_paypal.nil?
          @mensaje_inscripcion = detalle_pago_inscripcion.mensaje_error_paypal
        else
          @mensaje_inscripcion = @inscripcion.mensaje_inscripcion
        end
        format.html { render action: 'new', id_torneo: params[:id_torneo] }
      end
    end
  end

  def es_retornado_de_pasarela_de_pago
    !params[:paymentId].nil? || !params[:PayerID].nil?
  end

  def hots_formulario_params
    params.require(:hots_formulario).permit(:capitan_nick, :nombre_equipo, :titular_numero1, :titular_numero2, :titular_numero3, :titular_numero4, :suplente_numero1, :suplente_numero2)
  end

  def sc2_forms_params
    params.require(:sc2_form).permit(:race)
  end

  def torneo_params
    params.require(:torneo).permit(:id)
  end

  def hearthstone_form_params
    params.require(:hearthstone_form).permit(:battletag, :correo)
  end
  
end
