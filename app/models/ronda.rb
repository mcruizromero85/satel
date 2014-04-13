class Ronda < ActiveRecord::Base
	validates_presence_of :inicio_fecha, :message => ", las fechas de las rondas no pueden estar vacias"
	validates_presence_of :inicio_tiempo, :message => ", las horas de las rondas no pueden estar vacias"
	belongs_to :torneo
	has_many :encuentros

	def inicio_ronda
		fecha=self.inicio_fecha
		tiempo=self.inicio_tiempo
		Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
	end
end
