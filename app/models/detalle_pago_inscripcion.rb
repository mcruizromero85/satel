require 'paypal-sdk-rest'
include PayPal::SDK::REST

class DetallePagoInscripcion < ActiveRecord::Base
  belongs_to :torneos
  def crear_pago
  	@payment = PayPal::SDK::REST::Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => "paypal" },
      :redirect_urls => {
        :return_url => "http://localhost:3000/inscripciones/confirmar/" + torneo.id.to_s,
        :cancel_url => "http://localhost:3000/guide/pay_paypal/ruby?cancel=true" },
      :transactions => [ {
        :amount => {
          :total => monto_inscripcion.to_s,
          :currency => "USD" },
        :description => "Completa tu inscripción" } ] } )
    @payment.create
  end

  def cerrar_pago(payment_id, payer_id)
  	payment = Payment.find(payment_id)
    payment.execute(:payer_id => payer_id)
  end

  def mensaje_error_paypal
  	@payment.error
  end
 
end
