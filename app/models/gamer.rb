class Gamer < ActiveRecord::Base
  has_many :torneos
  has_many :inscripciones
  has_many :authentications, autosave: true

  def etiqueta_para_bracket
    if nick.nil? || nick == ''
      return nombres
    else
      return nick
    end
  end

  def esta_inscrito(torneo)
    true if inscripcion_en_torneo(torneo)
  end

  def esta_confirmado(torneo)
    if inscripcion_en_torneo(torneo) || torneo.gamer == self
      true
    else
      false
    end
  end

  def etiqueta_para_chat(torneo)
    if torneo.gamer == self
      nombres + '(Admin)'
    else
      inscripcion_en_torneo(torneo).etiqueta_chat
    end
  end

  def etiqueta_llave(torneo)
    if torneo.gamer == self
      nombres + '(Admin)'
    else
      inscripcion_en_torneo(torneo).etiqueta_llave
    end
  end

  def contrincante_inscrito_actual(torneo)
    encuentro = encuentro_actual(torneo)    
    if encuentro.gamerinscritoa == inscripcion_en_torneo(torneo)
      encuentro.gamerinscritob
    else
      encuentro.gamerinscritoa
    end
  end

  def encuentro_actual(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    encuentro = Encuentro.where('encuentros.ronda_id in (:rondas_ids) and encuentros.gamerinscrito_ganador_id is null and (encuentros.gamerinscritoa_id = :inscripcion_id or encuentros.gamerinscritob_id = :inscripcion_id)',rondas_ids: torneo.rondas.ids, inscripcion_id: inscripcion.id).take
  end

  def inscripcion_en_torneo(torneo)
    Inscripcion.find_by(torneo_id: torneo.id, estado: 'Confirmado', gamer_id: self.id)
  end
end
