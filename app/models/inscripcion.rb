class Inscripcion < ActiveRecord::Base
  
  validates :torneo, uniqueness: { scope: :gamer, message: ', Ya estás inscrito al torneo, espera la fase de confirmación' }
  #validates :torneo, uniqueness: { scope: :gamer, message: ', El torneo esta en Checkin' }
  #validates :torneo, acceptance: { accept: ['TRUE', 'accepted'] }
  
  belongs_to :gamer
  belongs_to :torneo, autosave: false  
  has_one :hots_formulario, dependent: :delete
  has_one :sc2_form, dependent: :delete
  has_one :hearthstone_form, dependent: :delete
  #accepts_nested_attributes_for :gamer
  #accepts_nested_attributes_for :hots_formulario
  #accepts_nested_attributes_for :sc2_form
  accepts_nested_attributes_for :hearthstone_form
  #validates_associated :hots_formulario, if: "torneo.juego.id == " + ID_JUEGO_HOTS.to_s
  #validates_associated :sc2_form, if: "torneo.juego.id == " + ID_JUEGO_SC2.to_s
  #validates_associated :hearthstone_form, if: "torneo.juego.id == " + ID_JUEGO_HEARTHSTONE.to_s
  validates_associated :gamer
  validate :torneo_cerrado
  #validates :etiqueta_llave, presence: { message: ', La etiqueta a mostrar en las llaves no se generó correctamente' }
  #validates :etiqueta_chat, presence: { message: ', La etiqueta a mostrar en el chat no se generó correctamente' }
  attr_accessor :mensaje_inscripcion
  
  def self.inscribir_y_confirmar_free_wins(torneo, free_wins_faltantes)
    free_wins_faltantes.times do | contador_free_win |
      gamer = Gamer.buscar_o_crear_free_win('Free win ' + (contador_free_win + 1).to_s)
      inscripcion = Inscripcion.new
      inscripcion.torneo = torneo
      inscripcion.gamer = gamer
      inscripcion.nick = gamer.nick
      inscripcion.tipo_inscripcion = 0
      inscripcion.estado = 'Confirmado'
      inscripcion.etiqueta_llave = 'Free Win'
      inscripcion.etiqueta_chat = 'Free Win'
      inscripcion.save
    end
  end

  def inscribir    
    estado = 'No Confirmado'
    if save
      self.mensaje_inscripcion = "Tu inscripción se guardó satisfactoriamente"
      self.mensaje_inscripcion = 'Tu inscripción se guardó satisfactoriamente, pero estás en cola, tu posición es ' + torneo.inscripciones.count.to_s  if torneo.inscripciones.count > torneo.vacantes
      true
    end
  end

  def torneo_cerrado
    errors.add(:torneo, ', Las inscripciones ya cerraron para el torneo, volver') if (torneo.cierre_inscripcion - Time.new) < 0   
  end

  def confirmar(id_transaccion = nil)
    self.estado = 'Confirmado'
    self.id_transaccion_pago = id_transaccion unless id_transaccion.nil?
    save
  end

end
