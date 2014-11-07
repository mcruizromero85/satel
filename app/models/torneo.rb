class Torneo < ActiveRecord::Base
	validates_presence_of :titulo, :message => ", el título es un dato obligatorio" 
	validates_length_of :titulo, :within => 30..100, :message => ", el título debe estar entre 30 y 100 caracteres"
	validates_presence_of :cierre_inscripcion_fecha, :message => ", la fecha debe estar en formato dd/mm/yyyy" 
	validates_presence_of :cierre_inscripcion_tiempo, :message => ", la hora debe estar en formato hh:mm AM/PM"		
	validates_format_of(:paginaweb, :with => URI::regexp(%w(http https)), :on => :create, :message=>", la página web debe tener el formato de una url, incluido http:// o https://")
	validate :fecha_cierre_mayor_que_actual
	validate :fecha_registro_entre_rondas
	validate :ronda_numero_uno_mayor_fecha_inscripcion
	validate :rondas_existentes_por_vacantes
	validate :cantidad_minima_confirmados
	validates_numericality_of :periodo_confirmacion_en_minutos
	belongs_to :gamer
	belongs_to :juego , autosave: false
	has_many :rondas , autosave: true
	has_many :inscripciones, autosave: true

	def cantidad_minima_confirmados
		print "HOLAAAAAAAAA"
		cantidad_confirmados=Gamer.joins(:inscripciones).where("inscripciones.torneo_id = :torneo_id and inscripciones.estado = :estado" , torneo_id: self.id, estado: "Confirmado").count
		print "GGG: " + self.estado
		print "GGG: " + cantidad_confirmados.to_s
		if self.estado == "Iniciado" and cantidad_confirmados < 4
		      errors.add(:vacantes, ", El Torneo debe tener como mínimo 4 gamers confirmados")
		end 
	end

	def cierre_inscripcion
		if self.cierre_inscripcion_fecha != nil and self.cierre_inscripcion_tiempo != nil then
			fecha=self.cierre_inscripcion_fecha
			tiempo=self.cierre_inscripcion_tiempo
			Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
		end
	end

	def inicio_fecha_hora_confirmacion			
			fecha=self.cierre_inscripcion_fecha
			tiempo=self.cierre_inscripcion_tiempo
			fecha_hora_inscripcion=Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
			return (fecha_hora_inscripcion - (periodo_confirmacion_en_minutos * 60))
	end

	def fecha_cierre_mayor_que_actual
		if self.estado == "Creado"
		    if (cierre_inscripcion.to_i - Time.new.to_i) < 0 then 
		      errors.add(:cierre_inscripcion_fecha, ", la fecha de cierre de inscripciones tiene que ser mayor a la actual")
		    end
		end
  	end

  	def ronda_numero_uno_mayor_fecha_inscripcion
  		if rondas.size > 0 then
			if ( rondas[0].inicio_ronda.to_i - cierre_inscripcion.to_i) < 0 then 
				errors.add(:cierre_inscripcion_fecha, ", la fecha de la primera ronda debe ser mayor a la fecha de cierre de inscripcion")
			end		
		end
	end

  	def fecha_registro_entre_rondas
  		ronda_anterior=nil

  		rondas.each do | ronda |
  		  if ronda_anterior != nil && ((ronda.inicio_ronda - ronda_anterior.inicio_ronda) < 0 ) then
  		  	errors.add(:rondas,", la fecha de inicio de la ronda " + ronda.numero.to_s + " debe ser mayor a la ronda " + ronda_anterior.numero.to_s)
  		  else
  		  	ronda_anterior=ronda
  		  end
	    end
	end

	def rondas_existentes_por_vacantes
		if rondas.size != TorneosHelper.obtener_rondas_por_vacantes(vacantes) then
			errors.add(:rondas,", todas las rondas deben estar definidas")
		end
	end

	def generar_encuentros
		if self.estado == "Iniciado"
			ronda=self.rondas.first
			@array_ids_aleatorios_de_gamers = Array.new
			@array_nombres_aleatorios_de_gamers = Array.new

			ronda.encuentros.each do | encuentro |
				@array_ids_aleatorios_de_gamers << encuentro.gamera.id
				@array_nombres_aleatorios_de_gamers << encuentro.gamera.nombres
				if encuentro.gamerb != nil				
					@array_ids_aleatorios_de_gamers << encuentro.gamerb.id
					@array_nombres_aleatorios_de_gamers << encuentro.gamerb.nombres
				end
			end
		else
			array_gamers_confirmados = Gamer.joins(:inscripciones).where("inscripciones.torneo_id = :torneo_id and inscripciones.estado = :estado" , torneo_id: self.id, estado: "Confirmado").limit(self.vacantes).order('inscripciones.id')
			@array_ids_aleatorios_de_gamers = array_gamers_confirmados.pluck(:id).sample(self.vacantes)
			@array_nombres_aleatorios_de_gamers = array_gamers_confirmados.pluck(:nombres).sample(self.vacantes)
		end
	end

	def array_encuentros_para_generar_llaves
		TorneosHelper.obtener_array_para_llaves(@array_nombres_aleatorios_de_gamers,self.vacantes)
	end

	def array_encuentros_para_guardar_llaves
		TorneosHelper.obtener_array_doble_de_encuentros(@array_ids_aleatorios_de_gamers,self.vacantes)
	end

	def array_resultado_encuentros_para_generar_llaves
        TorneosHelper.obtener_array_resultados_para_llaves(@array_nombres_aleatorios_de_gamers,self.vacantes)
	end
end
