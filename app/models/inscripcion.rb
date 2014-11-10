class Inscripcion < ActiveRecord::Base
	validates :torneo, uniqueness: { scope: :gamer, message: ", Ya estas inscrito en este torneo" }
	belongs_to :gamer
	belongs_to :torneo  , autosave: false

	def registrar		
		if self.torneo.periodo_confirmacion_en_minutos == 0
			self.estado = "Confirmado"
		else
			self.estado = "No confirmado"
		end		
		self.save		
	end

	def mensaje_inscripcion
		print "HOLLAAA"
		print "HOLLAAA:" + self.estado
		print "HOLLAAA:" + self.new_record?.to_s
		if self.new_record? == false and self.estado == "Confirmado"
			print "HOLLAAA BBBB"
			mensaje="Tu confirmación se realizó con exito"
			if self.torneo.inscripciones.count > self.torneo.vacantes
				print "HOLLAAA CCCC"
				mensaje=mensaje + "\n Tu posición es " + self.torneo.inscripciones.count.to_s + " de " + self.torneo.vacantes.to_s + " vacantes, estás en cola"
			end
		end
		return mensaje
	end

end
