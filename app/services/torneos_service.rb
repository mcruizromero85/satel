module TorneosService
	require 'active_support/core_ext/date'

	def self.iniciar_torneo torneo
		torneo.update
	end

	def self.obtener_torneos_para_portada
		Torneo.all.order(:cierre_inscripcion_fecha,:cierre_inscripcion_tiempo).limit(20).where("date(cierre_inscripcion_fecha) > date(:fecha_actual) or ( cierre_inscripcion_tiempo > time :hora_actual and date(cierre_inscripcion_fecha) = date(:fecha_actual) )",{fecha_actual: Time.new.strftime("%F"), hora_actual:Time.new.strftime("%T")})
	end

	def self.obtener_torneo_con_valores_inicializados
		torneo = Torneo.new
	    torneo.vacantes=8
	    torneo.inicio_torneo_fecha = (Time.new + (60 * 60 * 2)).to_date
	    torneo.inicio_torneo_tiempo = Time.new + (60 * 60 * 2)
	    torneo.cierre_inscripcion_fecha = (Time.new + ((60 * 60 * 2) - (45 * 60) )).to_date
	    torneo.cierre_inscripcion_tiempo = Time.new + ((60 * 60 * 2) - (45 * 60) )
	    return torneo
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

		flag_existe_error=false
	    rondas_contador = TorneosHelper.obtener_rondas_por_vacantes(torneo.vacantes)

	    for i in 1..rondas_contador
	      if rondas["ronda"+i.to_s] != nil
	        ronda=Ronda.new(rondas["ronda"+i.to_s].permit(:numero,:inicio_fecha,:inicio_tiempo,:modo_ganar))

	        if ronda.inicio_fecha == nil || ronda.inicio_tiempo == nil then
	          torneo.errors.add(:inicio_torneo,"las fechas de las rondas no pueden estar vacias")
	          flag_existe_error=true
	        end

	        if i > 1 then           
	          torneo.rondas.each do | ronda_previa|
	            if ronda_previa.numero == (i - 1) then
	              if (ronda.inicio_ronda - ronda_previa.inicio_ronda) <= ( 60 * 60) then
	                  torneo.errors.add(:inicio_torneo,", la fecha de inicio de la ronda " + ronda.numero.to_s + " debe ser mayor por una hora a la ronda " + ronda_previa.numero.to_s)                  
	                  flag_existe_error=true
	              end
	              break
	            end
	          end
	        end
	        torneo.rondas << ronda
	      end
	    end

	    id_juego = rondas["juego"].permit(:id)[:id]
	    juego = Juego.new
	    juego.id = id_juego
	    torneo.juego = juego

	    if ((torneo.inicio_torneo.to_i - Time.new.to_i) < (60 * 60) ) then
	        torneo.errors.add(:inicio_torneo,"debe ser mayor a 1 hora desde la fecha actual")
	        flag_existe_error=true
	    end

	    return torneo.save
	end
end