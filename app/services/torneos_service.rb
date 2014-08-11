class TorneosService
	require 'active_support/core_ext/date'

	def self.iniciar_torneo(torneo)
		torneo.save
	end

	def self.obtener_torneos_para_portada
		Torneo.all.order(:cierre_inscripcion_fecha,:cierre_inscripcion_tiempo).limit(20).where("date(cierre_inscripcion_fecha) > date(:fecha_actual) or ( cierre_inscripcion_tiempo > time :hora_actual and date(cierre_inscripcion_fecha) = date(:fecha_actual) )",{fecha_actual: Time.new.strftime("%F"), hora_actual:Time.new.strftime("%T")})
	end



	def self.generar_estructura_llaves(torneo,inscripciones)

		torneo.inscripcions.order(:id).limit(torneo.vacantes).each do | inscripcion | 
	      inscripcion.peso_participacion =inscripciones["inscripcion"+inscripcion.id.to_s].permit(:peso_participacion)[:peso_participacion]
	      inscripcion.save
	    end
	    
	    if torneo.tipo_generacion == 'A' then
	      posiciones=TorneosHelper.obtener_posicion_de_ronda_aleatoriamente(torneo.vacantes,1)
	    elsif torneo.tipo_generacion == 'M' then
	      posiciones=TorneosHelper.obtener_posicion_de_ronda_manual(torneo.vacantes,1)      
	    else
	      posiciones=TorneosHelper.obtener_posicion_de_ronda_por_ranking(torneo.vacantes,1)
	    end
	    
	    indice_posiciones=0
	    torneo.inscripcions.order(:peso_participacion).each do | inscripcion | 
	      inscripcion.posicion_inicial=posiciones[indice_posiciones]
	      inscripcion.save
	      indice_posiciones=indice_posiciones+1
	    end

	    for i in  (indice_posiciones+1)..torneo.vacantes 
	      inscripcion = Inscripcion.new
	      inscripcion.posicion_inicial=posiciones[indice_posiciones]
	      inscripcion.estado_confirmacion='C'
	      inscripcion.fecha_inscripcion=Time.new
	      inscripcion.peso_participacion=i
	      inscripcion.gamer = Gamer.find(-1000)
	      torneo.inscripcions << inscripcion
	      indice_posiciones=indice_posiciones+1
	    end
	    torneo.save
	end

	def self.guardar_torneo(torneo,rondas)

		
	    rondas_contador = TorneosHelper.obtener_rondas_por_vacantes(torneo.vacantes)

	    for i in 1..rondas_contador
	      if rondas["ronda"+i.to_s] != nil
	        ronda=Ronda.new(rondas["ronda"+i.to_s].permit(:numero,:inicio_fecha,:inicio_tiempo,:modo_ganar))
	        if ronda.valid?
	        	torneo.rondas << ronda
	    	end
	      end
	    end

	    id_juego = rondas["juego"].permit(:id)[:id]
	    juego = Juego.new
	    juego.id = id_juego
	    torneo.juego = juego

	    torneo.save


	    
	end
end