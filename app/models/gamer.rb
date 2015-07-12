class Gamer < ActiveRecord::Base
  has_many :torneos
  has_many :inscripciones
  has_many :authentications, autosave: true

  def esta_listo_contrincante_en_encuentro_actual(torneo)
    encuentro = encuentro_actual(torneo)
    encuentro.gamerinscritoa.gamer == self && encuentro.flag_listo_gamerb || encuentro.gamerinscritob.gamer == self && encuentro.flag_listo_gamera
  end

  def esta_listo_en_encuentro_actual(torneo)
    encuentro = encuentro_actual(torneo)
    encuentro.gamerinscritoa.gamer == self && encuentro.flag_listo_gamera || encuentro.gamerinscritob.gamer == self && encuentro.flag_listo_gamerb
  end

  def gane_el_torneo(torneo)
    inscripcion = inscripcion_en_torneo(torneo)
    Encuentro.find_by(gamerinscrito_ganador: inscripcion, ronda: torneo.rondas.last)
  end

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
    encuentro = Encuentro.encuentro_actual_por_inscrito(inscripcion)
  end

  def inscripcion_en_torneo(torneo)
    Inscripcion.find_by(torneo_id: torneo.id, estado: 'Confirmado', gamer_id: self.id)
  end

  def contrincante_posiblea(torneo)
  end

  def contrincante_posibleb(torneo)
  end
end
