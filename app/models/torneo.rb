class Torneo < ActiveRecord::Base
	def cierre_inscripcion
		fecha=self.cierre_inscripcion_fecha
		tiempo=self.cierre_inscripcion_tiempo
		Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
	end
end
