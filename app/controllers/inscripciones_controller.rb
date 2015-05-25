class InscripcionesController < ApplicationController
  before_action :revisa_si_existe_gamer_en_sesion, only: [:new]

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
  end

  # GET /inscripciones/1/edit
  def edit
  end

  # POST /inscripciones
  # POST /inscripciones.json
  def create
    @torneo = Torneo.find(params[:id_torneo])
    gamer_params = params.require(:gamer).permit(:nick,:correo)
    current_gamer.nick = gamer_params[:nick]
    current_gamer.correo = gamer_params[:correo]
    current_gamer.save
    @inscripcion = Inscripcion.new
    @inscripcion.gamer = current_gamer
    @inscripcion.nick = gamer_params[:nick]
    @inscripcion.torneo = @torneo

    if @torneo.flag_pago_inscripciones == 1 
      detalle_pago_inscripcion = DetallePagoInscripcion.find_by(torneo_id: params[:id_torneo])
      respond_to do |format|
        if detalle_pago_inscripcion.crear_pago(@torneo.id) && @inscripcion.inscribir
          format.html { redirect_to detalle_pago_inscripcion.url_de_pago }
        else
          @mensaje_inscripcion=detalle_pago_inscripcion.mensaje_error_paypal
          format.html { render action: 'new', id_torneo: params[:id_torneo] }        
        end
      end
    else
      respond_to do |format|
        if @inscripcion.inscribir
           format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
        else          
           format.html { render action: 'new', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion } 
        end
      end
    end
  end

  def confirmar
    @torneo = Torneo.find(params[:id_torneo])
    @inscripcion = Inscripcion.find_by(torneo_id: params[:id_torneo], gamer_id: current_gamer.id)
    @inscripcion.estado = 'Confirmado'
    if @torneo.flag_pago_inscripciones == 1 
      detalle_pago_inscripcion = DetallePagoInscripcion.find_by(torneo_id: params[:id_torneo])
      
      if !es_retornado_de_pasarela_de_pago
        detalle_pago_inscripcion.crear_pago(@torneo.id)
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
          format.html { render action: 'new', id_torneo: params[:id_torneo], mensaje_inscripcion: detalle_pago_inscripcion.mensaje_error_paypal }  
        end
      end
    else
      respond_to do |format|
        if @inscripcion.confirmar
           format.html { redirect_to action: 'index', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion }
        else          
           format.html { render action: 'new', id_torneo: params[:id_torneo], mensaje_inscripcion: @inscripcion.mensaje_inscripcion } 
        end
      end
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

  def es_retornado_de_pasarela_de_pago
    !params[:paymentId].nil? || !params[:PayerID].nil?
  end

end
