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
    true if Inscripcion.find_by(torneo_id: torneo.id, gamer_id: self.id)
  end

  def esta_confirmado(torneo)
    if Inscripcion.find_by(torneo_id: torneo.id, gamer_id: self.id, estado: 'Confirmado')
      true
    else
      false
    end
  end
end
