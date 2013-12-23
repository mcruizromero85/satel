module TorneosHelper
	require 'active_support/core_ext/date'

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
