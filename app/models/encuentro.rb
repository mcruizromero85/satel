class Encuentro < ActiveRecord::Base
  belongs_to :gamerinscritoa, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscritob, class_name: 'Inscripcion', autosave: false
  belongs_to :gamerinscrito_ganador, class_name: 'Inscripcion', autosave: false
  belongs_to :ronda, autosave: false
  belongs_to :encuentro_anterior_a, class_name: 'Encuentro'
  belongs_to :encuentro_anterior_b, class_name: 'Encuentro'

  def gano_gamer_a
  	self.gamerinscrito_ganador = self.gamerinscritoa
  	self.armar_siguiente_encuentro
  	self.save
  end

  def gano_gamer_b
  	self.gamerinscrito_ganador = self.gamerinscritob
  	self.armar_siguiente_encuentro
  	self.save
  end

  def armar_siguiente_encuentro
  	encuentro = Encuentro.new
  	if self.posicion_en_ronda.even?
  		encuentro.gamerinscritob = self.gamerinscrito_ganador
  		encuentro_anterior_b = self
  	else
  		encuentro.gamerinscritoa = self.gamerinscrito_ganador
  		encuentro_anterior_a = self
  	end
  	encuentro.ronda = self.ronda.ronda_siguiente
  	encuentro.save
  end
end
