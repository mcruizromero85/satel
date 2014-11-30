module TorneosHelper
	require 'active_support/core_ext/date'
	require 'uri'

	def self.obtener_bracket_segun_cantidad_confirmados(cantidad_gamers_confirmados)
		if cantidad_gamers_confirmados <= 8 
			8
		elsif cantidad_gamers_confirmados <= 16 
			16
		elsif cantidad_gamers_confirmados <= 32
			32
		else
			64
		end
	end

	def self.obtener_array_para_resultado_llaves(torneo)

    array_id_encuentros = Array.new(torneo.rondas.first.encuentros.count){[0,0]}
    contador=0
         
    torneo.rondas.first.encuentros.each do | encuentro |
    	if encuentro.gamerinscrito_ganador == encuentro.gamerinscritoa
    		array_id_encuentros[contador] = [1,0,encuentro.id]
    	elsif encuentro.gamerinscrito_ganador == encuentro.gamerinscritob
    		array_id_encuentros[contador] = [0,1,encuentro.id]
    	else
    		array_id_encuentros[contador] = [0,0,encuentro.id]
    	end	
      contador=contador+1
    end
		
		return array_id_encuentros
  end

	def self.obtener_array_para_llaves(torneo)
		array_para_llaves="["
		contador=1
		torneo.rondas.first.encuentros.each do | encuentro |
			if encuentro.gamerinscritoa != nil 
				array_para_llaves.concat("[\""+encuentro.gamerinscritoa.gamer.nombres+"\",")
			else
				array_para_llaves.concat("[\"\",")						
			end

			if encuentro.gamerinscritob != nil 
				array_para_llaves.concat("\""+encuentro.gamerinscritob.gamer.nombres+"\"]")
			else
				array_para_llaves.concat("\"\"]")			
			end

			if torneo.rondas.first.encuentros.count != contador
				array_para_llaves.concat(",")
			end
			contador=contador+1
		end
		array_para_llaves.concat("]")
		
		return array_para_llaves
  end

	def self.obtener_rondas_por_vacantes vacantes
		Math.log(vacantes, 2).ceil
	end

	def self.obtener_posicion_de_ronda_por_ranking(cantidad_vacantes,tipo_combinacion)
		if cantidad_vacantes==4 then
			return [1,4,3,2]
		elsif cantidad_vacantes==8 then
			return [1,8,5,3,4,6,7,2]
		elsif cantidad_vacantes==16 then
			return [1,16,7,9,5,11,3,13,4,14,8,10,6,12,2,15]
		else
			return [1,32,9,13,19,5,27,7,25,15,17,11,21,3,29,4,30,12,22,16,18,8,26,6,28,14,20,10,24,2,31]
		end		
	end

	def self.obtener_posicion_de_ronda_manual(cantidad_vacantes,tipo_combinacion)
		if cantidad_vacantes==4 then
			return [1,2,3,4]
		elsif cantidad_vacantes==8 then
			return [1,2,3,4,5,6,7,8]
		elsif cantidad_vacantes==16 then
			return [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
		else
			return [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]
		end		
	end

	def self.obtener_posicion_de_ronda_aleatoriamente(cantidad_vacantes,tipo_combinacion)
		conjunto=[1,2,3,4,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]
		return conjunto.sample(cantidad_vacantes)		
	end

	def self.obtenerFormatoCuentaRegresivaHastaLaFecha(fecha_cierre_inscripcion)

		diferencia_segundos_cierre_inscripcion_y_hoy=fecha_cierre_inscripcion.to_i - Time.new.to_i		
		formatoCuentaRegresiva=""
		diferenciaDias=0
		un_dia_en_segundos=60 * 60 * 24
		una_hora_en_segundos=60 * 60
		
		if diferencia_segundos_cierre_inscripcion_y_hoy >= un_dia_en_segundos then
			diferenciaDias = (diferencia_segundos_cierre_inscripcion_y_hoy *1.0 / 60 / 60 / 24 )
			diferencia_segundos_cierre_inscripcion_y_hoy -= (diferenciaDias.floor  * un_dia_en_segundos )
			formatoCuentaRegresiva = diferenciaDias.round.to_s + "d"
			if diferenciaDias.round >= 2 then
				diferencia_segundos_cierre_inscripcion_y_hoy=0
			end
		end

		
		if diferencia_segundos_cierre_inscripcion_y_hoy >= una_hora_en_segundos && diferenciaDias < 2 then
			
			if formatoCuentaRegresiva != "" then 
				formatoCuentaRegresiva+=" "
			end	
			difrenciaHoras = (diferencia_segundos_cierre_inscripcion_y_hoy * 1.0 / 60 / 60   )
			diferencia_segundos_cierre_inscripcion_y_hoy -= (difrenciaHoras.floor *  una_hora_en_segundos)
			formatoCuentaRegresiva += difrenciaHoras.round.to_s + "h"
		end

		if diferencia_segundos_cierre_inscripcion_y_hoy > 60 && diferenciaDias < 1 then
			if formatoCuentaRegresiva != "" then 
				formatoCuentaRegresiva+=" "
			end	
			diferenciaMinutos = diferencia_segundos_cierre_inscripcion_y_hoy * 1.0 / 60 
			diferencia_segundos_cierre_inscripcion_y_hoy -= ( diferenciaMinutos.floor * 60 )
			formatoCuentaRegresiva += diferenciaMinutos.floor.to_s + "m"
		end

		if diferencia_segundos_cierre_inscripcion_y_hoy > 0 && diferenciaDias < 1 then
			if formatoCuentaRegresiva != "" then 
				formatoCuentaRegresiva+=" "
			end	
			formatoCuentaRegresiva += (diferencia_segundos_cierre_inscripcion_y_hoy ).to_s + "s"
		end
		return formatoCuentaRegresiva
	end

	
end