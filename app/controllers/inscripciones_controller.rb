class InscripcionesController < ApplicationController
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new, :index]

  # GET /inscripciones
  # GET /inscripciones.json
  def index
    @inscripciones = Inscripcion.where(torneo_id:  params[:id_torneo]).order(:created_at)
    @torneo = Torneo.find(params[:id_torneo])
    @mensaje_inscripcion = params[:mensaje_inscripcion]
  end

  # GET /inscripciones/1
  # GET /inscripciones/1.json
  def show
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
    @inscripcion = Inscripcion.new.from_json(params[:inscripcion])
    
    if @inscripcion.torneo.juego.id == ID_JUEGO_HOTS 
      gamer_params = params.require(:gamer).permit(:correo)
      hots_formulario = HotsFormulario.new(hots_formulario_params)
      current_gamer.nick = hots_formulario.capitan_nick
      current_gamer.correo = gamer_params[:correo]
      current_gamer.save
      @inscripcion = Inscripcion.new
      @inscripcion.gamer = current_gamer
      @inscripcion.nick = hots_formulario.nombre_equipo
      @inscripcion.torneo = @torneo
      @inscripcion.hots_formulario = hots_formulario
      @inscripcion.etiqueta_llave = hots_formulario.nombre_equipo
      @inscripcion.etiqueta_chat = hots_formulario.capitan_nick + '(' + hots_formulario.nombre_equipo + ')'
    elsif @inscripcion.torneo.juego.id == ID_JUEGO_SC2 
      gamer_params = params.require(:gamer).permit(:correo,:battletag)
      sc2_form = Sc2Form.new(sc2_forms_params)
      current_gamer.nick = gamer_params[:battletag]
      current_gamer.battletag = gamer_params[:battletag]
      current_gamer.correo = gamer_params[:correo]      
      current_gamer.save
      @inscripcion = Inscripcion.new
      @inscripcion.gamer = current_gamer
      @inscripcion.nick = gamer_params[:battletag]
      @inscripcion.torneo = @torneo
      @inscripcion.sc2_form = sc2_form
      @inscripcion.etiqueta_llave = current_gamer.battletag
      @inscripcion.etiqueta_chat = current_gamer.battletag
    else
      @inscripcion.gamer = current_gamer
      @inscripcion.etiqueta_llave = @inscripcion.hearthstone_form.battletag
      @inscripcion.etiqueta_chat = @inscripcion.hearthstone_form.battletag
    end
    inscribir
  end

  def confirmar
    @inscripcion = Inscripcion.find(params[:id_inscripcion])
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

  private

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
        mensaje_inscripcion = 'Inscripción realizada con éxito'
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: mensaje_inscripcion }
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
  
end
