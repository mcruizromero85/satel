class Inscripcion < ActiveRecord::Base
  validates :torneo, uniqueness: { scope: :gamer, message: ', Ya estas inscrito en este torneo' }
  belongs_to :gamer
  belongs_to :torneo, autosave: false
  has_many :datos_inscripcion_registrado

  def agregar_dato_inscripcion_registrado(datos_inscripcion_registrado)
    self.datos_inscripcion_registrado << datos_inscripcion_registrado
  end

  def self.total_confirmados_por_torneo(torneo)
    Gamer.joins(:inscripciones).where('inscripciones.torneo_id = :torneo_id and inscripciones.estado = :estado', torneo_id: torneo.id, estado: 'Confirmado').count
  end

  def self.inscritos_confirmados_en_el_torneo(torneo)
    Inscripcion.where('torneo_id = :torneo_id and estado = :estado', torneo_id: torneo.id, estado: 'Confirmado').limit(torneo.vacantes).order('inscripciones.id')
  end

  def save
    if self.new_record?
      self.estado = 'En verificación de datos'
    elsif torneo.periodo_confirmacion_en_minutos == 0 && self.new_record?
      self.estado = 'Confirmado'
    else
      self.estado = 'Confirmado'
    end
    super
  end

  def mensaje_inscripcion
    if self.new_record? == false && estado == 'Confirmado'
      mensaje = 'Tu confirmación se realizó con exito'
      if torneo.inscripciones.count > torneo.vacantes
        mensaje = mensaje + "\n Tu posición es " + torneo.inscripciones.count.to_s + ' de ' + torneo.vacantes.to_s + ' vacantes, estás en cola'
      end
    else
      mensaje = 'Tu Inscripción se realizó con exito'
    end
    mensaje
  end
end
