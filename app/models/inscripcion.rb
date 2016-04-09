class Inscripcion < ActiveRecord::Base
  validates :torneo, uniqueness: { scope: :gamer, message: ', Ya estas inscrito en este torneo' }
  belongs_to :gamer
  belongs_to :torneo, autosave: false  
  has_one :hots_formulario, dependent: :delete
  has_one :sc2_form, dependent: :delete
  has_one :hearthstone_form, dependent: :delete
  accepts_nested_attributes_for :gamer
  accepts_nested_attributes_for :hots_formulario
  accepts_nested_attributes_for :sc2_form
  accepts_nested_attributes_for :hearthstone_form
  validates_associated :hots_formulario, if: "torneo.juego.id == " + ID_JUEGO_HOTS.to_s
  validates_associated :sc2_form, if: "torneo.juego.id == " + ID_JUEGO_SC2.to_s
  validates_associated :hearthstone_form, if: "torneo.juego.id == " + ID_JUEGO_HEARTHSTONE.to_s
  validates_associated :gamer
  validates :etiqueta_llave, presence: { message: ', La etiqueta a mostrar en las llaves no se generó correctamente' }
  validates :etiqueta_chat, presence: { message: ', La etiqueta a mostrar en el chat no se generó correctamente' }
  validate :unless_one_form_associated

  def unless_one_form_associated
    if self.hots_formulario.nil? and self.sc2_form.nil? and self.hearthstone_form.nil?
        errors.add(:gamer, "No has completado todo el formulario")
    end
  end

  def self.inscripciones_confirmadas_permitidas_con_free_wins(torneo, _flag_aleatorio)
    array_inscritos_confirmados = inscripciones_permitidas_y_confirmadas_en_el_torneo(torneo)
    cantidad_slots_correctos_para_las_llaves = TorneosHelper.obtener_cantidad_de_slots_segun_gamers_confirmados(array_inscritos_confirmados.count)
    free_wins_faltantes = cantidad_slots_correctos_para_las_llaves - array_inscritos_confirmados.count
    if free_wins_faltantes > 0
      inscribir_y_confirmar_free_wins(torneo, free_wins_faltantes)
      array_inscritos_confirmados.concat(freewins_en_el_torneo(torneo))
    end

    array_inscritos_confirmados.sample(cantidad_slots_correctos_para_las_llaves)

    array_inscritos_confirmados
  end

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

  def self.freewins_en_el_torneo(torneo)
    Inscripcion.where('torneo_id = :torneo_id and estado = :estado and tipo_inscripcion = 0 ', torneo_id: torneo.id, estado: 'Confirmado').limit(torneo.vacantes).order('inscripciones.id')
  end

  def self.inscripciones_permitidas_y_confirmadas_en_el_torneo(torneo)
    Inscripcion.where('torneo_id = :torneo_id and estado = :estado ', torneo_id: torneo.id, estado: 'Confirmado').limit(torneo.vacantes).order('inscripciones.id')
  end

  def inscribir
    if !gamer.valid?
      errors.add(:gamer,  "El battle tag no tiene el formato nick#1234")
      return
    end    
    self.estado = 'Inscrito'
    puts self
    self.save
  end

  def confirmar(id_transaccion = nil)
    self.estado = 'Confirmado'
    self.id_transaccion_pago = id_transaccion unless id_transaccion.nil?
    save
  end

  def mensaje_inscripcion
    if self.new_record? == false && estado == 'Confirmado'
      mensaje = 'Tu confirmación se realizó con éxito '
      mensaje = mensaje + "\n Tu id de pago es : " + id_transaccion_pago unless id_transaccion_pago.nil?
      if torneo.inscripciones.count > torneo.vacantes
        mensaje = mensaje + "\n Tu posición es " + torneo.inscripciones.count.to_s + ' de ' + torneo.vacantes.to_s + ' vacantes, estás en cola'
      end
    else
      mensaje = 'Tu Inscripción se realizó con éxito'
    end
    mensaje
  end
end
