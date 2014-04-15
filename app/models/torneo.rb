class Torneo < ActiveRecord::Base

	validates_presence_of :titulo, :message => "El título es un dato obligatorio" 
	validates_length_of :titulo, :within => 30..100, :message => "El torneo debe tener como mínimo 30 caracteres y como máximo 100"
	validates_format_of(:paginaweb, :with => URI.regexp(['http']), :on => :create, :message=>"Debe tener el formato de una url")

	def cierre_inscripcion
		fecha=self.cierre_inscripcion_fecha
		tiempo=self.cierre_inscripcion_tiempo
		Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
	end

	def inicio_torneo
		fecha=self.inicio_torneo_fecha
		tiempo=self.inicio_torneo_tiempo
		Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
	end

	belongs_to :juego , autosave: false
	has_many :rondas , autosave: true
	has_many :inscripcions, autosave: true
end
