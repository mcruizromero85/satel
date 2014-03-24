class Torneo < ActiveRecord::Base
	validates_presence_of :titulo, :message => "El título es un dato obligatorio" 
	validates_length_of :titulo, :within => 30..100, :message => "El torneo debe tener como mínimo 30 caracteres y como máximo 100"

	def cierre_inscripcion
		fecha=self.cierre_inscripcion_fecha
		tiempo=self.cierre_inscripcion_tiempo
		Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
	end

	has_many :rondas
	has_many :inscripcions
end
