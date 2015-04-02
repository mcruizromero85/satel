class Inscripcion < ActiveRecord::Base
  validates :torneo, uniqueness: { scope: :gamer, message: ', Ya estas inscrito en este torneo' }
  belongs_to :gamer
  belongs_to :torneo, autosave: false
  has_many :datos_inscripcion_registrado

  def self.inscritos_confirmados_en_el_torneo_con_free_wins(torneo)
    array_inscritos_confirmados = inscritos_confirmados_en_el_torneo(torneo)
    cantidad_slots_que_deberia_tener = TorneosHelper.obtener_cantidad_de_slots_segun_gamers_confirmados(array_inscritos_confirmados.count)

    free_wins_faltantes = cantidad_slots_que_deberia_tener - array_inscritos_confirmados.count
    if free_wins_faltantes > 0
      inscribir_free_wins(torneo, free_wins_faltantes)
      array_inscritos_confirmados = inscritos_confirmados_en_el_torneo(torneo)
    end
    array_inscritos_confirmados.sample(cantidad_slots_que_deberia_tener)
  end

  def self.inscribir_free_wins(torneo, free_wins_faltantes)
    free_wins_faltantes.times do | contador_free_win |
      gamer = Gamer.find_by(nick: 'Free win ' + (contador_free_win + 1).to_s)
      inscripcion = Inscripcion.new
      inscripcion.torneo = torneo
      inscripcion.gamer = gamer
      inscripcion.tipo_inscripcion = 1
      inscripcion.estado = 'Confirmado'
      inscripcion.save
    end
  end

  def agregar_dato_inscripcion_registrado(datos_inscripcion_registrado)
    self.datos_inscripcion_registrado << datos_inscripcion_registrado
  end

  def self.total_confirmados_por_torneo(torneo)
    Gamer.joins(:inscripciones).where('inscripciones.torneo_id = :torneo_id and inscripciones.estado = :estado and gamers.nick not like \'%Free win%\'', torneo_id: torneo.id, estado: 'Confirmado').count
  end

  def self.inscritos_confirmados_en_el_torneo(torneo)
    Inscripcion.where('torneo_id = :torneo_id and estado = :estado', torneo_id: torneo.id, estado: 'Confirmado').limit(torneo.vacantes).order('inscripciones.id')
  end

  def inscribir
    if gamer.nick.nil?
      errors.add(:gamer, ', Debes colocar tu nick')
      return
    end
    self.estado = 'Inscrito'
    save
  end

  def confirmar
    self.estado = 'Confirmado'
    save
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
