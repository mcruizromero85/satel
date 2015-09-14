require 'paypal-sdk-rest'
include PayPal::SDK::REST

class DetallePagoInscripcion < ActiveRecord::Base
  belongs_to :torneo
  def crear_pago(torneo_id, torneo_titulo)
    @payment = PayPal::SDK::REST::Payment.new(
      intent: 'sale',
      payer: {
        payment_method: 'paypal' },
      redirect_urls: {
        return_url: URL_RETORNO_PAYPAL + torneo_id.to_s,
        cancel_url: URL_CANCELAR_PAYPAL },
      transactions: [{
        amount: {
          total: (sprintf('%.2f', monto_inscripcion)),
          currency: 'USD',
          details: {
            subtotal: (sprintf('%.2f', monto_inscripcion))
          }
        },
        item_list: {
          items: [{
            name: ('Inscripción para: ' + torneo_titulo)[0..126],
            price: (sprintf('%.2f', monto_inscripcion)),
            currency: 'USD',
            quantity: 1 }] },
        description: 'Completa tu inscripción' }])
    @payment.create
  end

  def url_de_pago
    @payment.links[1].href
  end

  def cerrar_pago(payment_id, payer_id)
    @payment = Payment.find(payment_id)
    @payment.execute(payer_id: payer_id)
  end

  def mensaje_error_paypal
    unless @payment.nil?
      @payment.error.message.to_s unless @payment.error.nil?
    end
  end

  def id_transaccion
    @payment.id
  end

  def total_price_pool
    (Inscripcion.inscripciones_permitidas_y_confirmadas_en_el_torneo(torneo).size * monto_inscripcion) + monto_auspiciado
  end
end
