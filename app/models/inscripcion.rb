class Inscripcion < ActiveRecord::Base
  
  validates :torneo, uniqueness: { scope: :gamer, message: ', Ya estás inscrito al torneo, espera la fase de check-in' }
  belongs_to :gamer
  belongs_to :torneo
  has_one :hots_formulario, dependent: :delete
  has_one :sc2_form, dependent: :delete
  has_one :hearthstone_form, dependent: :delete
  accepts_nested_attributes_for :hearthstone_form
  validates_associated :gamer
  validate :torneo_cerrado
  attr_accessor :mensaje_inscripcion
  
  def inscribir
    self.estado = 'No Confirmado'
    if save
      self.mensaje_inscripcion = "Tu inscripción se guardó satisfactoriamente"
      self.mensaje_inscripcion = 'Tu inscripción se guardó satisfactoriamente, pero estás en cola, tu posición es ' + torneo.inscripciones.count.to_s  if torneo.inscripciones.count > torneo.vacantes
      true
    end
  end

  def torneo_cerrado
    errors.add(:torneo, ', Las inscripciones ya cerraron para el torneo, volver') if (torneo.cierre_inscripcion - Time.new) < 0   
  end

end
