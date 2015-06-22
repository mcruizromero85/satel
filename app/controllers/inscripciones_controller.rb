class InscripcionesController < ApplicationController
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new, :index]

  # GET /inscripciones
  # GET /inscripciones.json
  def index
    @inscripciones = Inscripcion.where(torneo_id:  params[:id_torneo], tipo_inscripcion: nil).order(:created_at)
    @torneo = Torneo.find(params[:id_torneo])
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
    @mensaje_inscripcion_error = params[:mensaje_inscripcion_error] if !params[:mensaje_inscripcion_error].nil?
  end

  # GET /inscripciones/1/edit
  def edit
  end

  # POST /inscripciones
  # POST /inscripciones.json
  def create
    @torneo = Torneo.find(params[:id_torneo])
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

    if  @torneo.flag_pago_inscripciones == 1
      inscribir_y_cobrar
    else
      inscribir
    end
  end

  def confirmar
    @torneo = Torneo.find(params[:id_torneo])
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    @inscripcion.estado = 'Confirmado'
    
    if  @torneo.flag_pago_inscripciones == 1
      confirmar_y_cerrar_pago
    else 
      solo_confirmar
    end
      

   
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
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    @inscripcion.estado = 'Confirmado'

    respond_to do |format|
      if @inscripcion.confirmar
        format.html { redirect_to action: 'iniciar_torneo', controller: 'torneos' , id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
      else
        @torneo = Torneo.find(params[:id_torneo])
        format.html { render action: 'new' }
      end
    end
  end

  def confirmar_y_cerrar_pago
    detalle_pago_inscripcion = DetallePagoInscripcion.find_by(torneo_id: params[:id_torneo])
    if !es_retornado_de_pasarela_de_pago
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
          mensaje_inscripcion_error = "Error interno contacta, con el administrador: mcruizromero85@gmail.com"
        end
        format.html { redirect_to action: 'new', id_torneo: params[:id_torneo], mensaje_inscripcion_error: mensaje_inscripcion_error }  
      end
    end
  end

  def inscribir
    respond_to do |format|
      if @inscripcion.inscribir
        mensaje_inscripcion="Inscripción realizada con éxito"
        format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: mensaje_inscripcion}
      else
        @torneo = Torneo.find(params[:id_torneo])
        @mensaje_inscripcion=@inscripcion.mensaje_inscripcion
        format.html { render action: 'new', id_torneo: params[:id_torneo] }        
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
          @mensaje_inscripcion=detalle_pago_inscripcion.mensaje_error_paypal
        else
          @mensaje_inscripcion=@inscripcion.mensaje_inscripcion
        end
        format.html { render action: 'new', id_torneo: params[:id_torneo] }        
      end
    end
  end

  def es_retornado_de_pasarela_de_pago
    !params[:paymentId].nil? || !params[:PayerID].nil?
  end

  def hots_formulario_params
      params.require(:hots_formulario).permit(:capitan_nick, :nombre_equipo, :titular_numero1,:titular_numero2,:titular_numero3,:titular_numero4,:suplente_numero1,:suplente_numero2)
  end

end
