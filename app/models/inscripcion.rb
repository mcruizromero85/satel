class Inscripcion < ActiveRecord::Base
	validates :torneo, uniqueness: { scope: :gamer, message: ", Ya estas inscrito en este torneo" }
	belongs_to :gamer
	belongs_to :torneo  , autosave: false

	def save		
		if self.new_record?
			self.estado="No confirmado"
		elsif self.torneo.periodo_confirmacion_en_minutos == 0 and self.new_record?
			self.estado = "Confirmado"		
		else
			self.estado="Confirmado"
		end
		super
	end

	def mensaje_inscripcion
		if self.new_record? == false and self.estado == "Confirmado"
			mensaje="Tu confirmación se realizó con exito"
			if self.torneo.inscripciones.count > self.torneo.vacantes
				mensaje=mensaje + "\n Tu posición es " + self.torneo.inscripciones.count.to_s + " de " + self.torneo.vacantes.to_s + " vacantes, estás en cola"
			end
		else
			mensaje="Tu Inscripción se realizó con exito"
		end
		return mensaje
	end

end
