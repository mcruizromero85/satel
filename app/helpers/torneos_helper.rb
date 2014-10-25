module TorneosHelper
	require 'active_support/core_ext/date'
	require 'uri'

	def self.obtener_array_doble_de_encuentros(array_id_gamers_aleatorio,vacantes)
        array_id_encuentros = Array.new(vacantes/2){[-1,-1]}
        contador_array_encuentros=0
        contador=1
        primer_gamer=-1
         
        array_id_gamers_aleatorio.each do | id |
           if contador % 2 == 0
               array_id_encuentros[contador_array_encuentros] = [primer_gamer,id]
               contador_array_encuentros=contador_array_encuentros+1
           else
               primer_gamer=id
               array_id_encuentros[contador_array_encuentros] = [primer_gamer,-1]
           end
           contador=contador+1
        end
        return array_id_encuentros
	end

    def self.obtener_array_para_llaves(array_gamers,cantidad_vacantes)
        contador=1
        array_para_llaves="["
        
        if array_gamers.count < cantidad_vacantes
            array_complementario = Array.new(cantidad_vacantes - array_gamers.count,"")
            array_gamers = array_gamers + array_complementario 
        end

        array_gamers.each do | gamer |
           if contador > cantidad_vacantes
               break 
           end
            
           if contador % 2 == 0 
               array_para_llaves.concat("\""+gamer+"\"]")
               if contador != cantidad_vacantes
                   array_para_llaves.concat(",")
               end
           else
               array_para_llaves.concat("[\""+gamer+"\",")
           end
           contador=contador+1
        end
        array_para_llaves.concat("]")
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
