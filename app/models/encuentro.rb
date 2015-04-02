class Encuentro < ActiveRecord::Base
  belongs_to :gamerinscritoa, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscritob, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscrito_ganador, class_name: 'Inscripcion', autosave: false
  belongs_to :ronda, autosave: false
  belongs_to :encuentro_anterior_a, class_name: 'Encuentro'
  belongs_to :encuentro_anterior_b, class_name: 'Encuentro'

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
