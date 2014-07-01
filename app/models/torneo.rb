class Torneo < ActiveRecord::Base

	validates_presence_of :titulo, :message => "El título es un dato obligatorio" 
	validates_length_of :titulo, :within => 30..100, :message => "El título debe estar entre 30 y 100 caracteres"
	validates_format_of(:paginaweb, :with => URI.regexp(['http']), :on => :create, :message=>"La página web debe tener el formato de una url")

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
