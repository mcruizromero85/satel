class Encuentro < ActiveRecord::Base
  belongs_to :gamerinscritoa, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscritob, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscrito_ganador, class_name: 'Inscripcion', autosave: false
  belongs_to :ronda, autosave: false
  belongs_to :encuentro_anterior_a, class_name: 'Encuentro'
  belongs_to :encuentro_anterior_b, class_name: 'Encuentro'
  has_many :partidas, -> { order('id ASC') }, autosave: false

  def es_la_final
    if ronda.ronda_siguiente.nil?
      true
    else
      false
    end
  end

  def self.encuentro_actual_por_inscrito(inscripcion)
    Encuentro.where('encuentros.ronda_id in (:rondas_ids) and encuentros.gamerinscrito_ganador_id is null and (encuentros.gamerinscritoa_id = :inscripcion_id or encuentros.gamerinscritob_id = :inscripcion_id)',rondas_ids: inscripcion.torneo.rondas.ids, inscripcion_id: inscripcion.id).take
  end

  def tiene_partidas_pendientes
    partidas_maximas = ronda.modo_ganar
    puntaje_gamera = puntaje_de_inscrito(gamerinscritoa)
    puntaje_gamerb = puntaje_de_inscrito(gamerinscritob)
    if (puntaje_gamera.to_i + puntaje_gamerb.to_i) < partidas_maximas.to_i
      true
    else
      false
    end
  end

  def puntaje_de_inscrito(inscrito)
    if self.gamerinscritoa == inscrito
      Partida.where('partidas.encuentro_id=:encuentro_id and partidas.estado = :estado and flag_gano_gamerinscritoa = :flag_gano_gamerinscritoa', encuentro_id: self.id, estado: 'Finalizado', flag_gano_gamerinscritoa: true ).size
    else
      Partida.where('partidas.encuentro_id=:encuentro_id and partidas.estado = :estado and flag_gano_gamerinscritob = :flag_gano_gamerinscritob', encuentro_id: self.id, estado: 'Finalizado', flag_gano_gamerinscritob: true ).size
    end    
  end

  def siguiente_partida
    partidas << Partida.create(encuentro: self)
  end

  def partida_actual
    partidas.where(estado: 'Pendiente').last
  end

  def iniciar_partidas
    self.estado = 'Iniciado'
    partidas.destroy_all
    partidas << Partida.create(encuentro: self)
  end

  def registrar_ganador
    armar_siguiente_encuentro
    save
  end

  def armar_siguiente_encuentro
    return if ronda.ronda_siguiente.nil?
    encuentro = Encuentro.where('ronda_id = ? and posicion_en_ronda = ?', ronda.ronda_siguiente.id, obtener_posicion_en_siguiente_ronda).first
    encuentro = Encuentro.new if encuentro.nil?
    if posicion_en_ronda.even?
      encuentro.gamerinscritob = gamerinscrito_ganador
      encuentro.encuentro_anterior_b = self
    else
      encuentro.gamerinscritoa = gamerinscrito_ganador
      encuentro.encuentro_anterior_a = self
    end
    encuentro.posicion_en_ronda = obtener_posicion_en_siguiente_ronda
    encuentro.ronda = ronda.ronda_siguiente
    encuentro.save
  end

  def ambos_estan_confirmados
    self.flag_listo_gamera && self.flag_listo_gamerb
  end

  private

  def obtener_posicion_en_siguiente_ronda
    if posicion_en_ronda > 10
      8
    elsif posicion_en_ronda > 8
      6
    elsif posicion_en_ronda > 6
      4
    elsif posicion_en_ronda > 4
      3
    elsif posicion_en_ronda > 2
      2
    else
      1
    end
  end
end
