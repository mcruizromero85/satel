module TorneosHelper
	require 'active_support/core_ext/date'

	def self.obtenerFormatoCuentaRegresivaHastaLaFecha(fecha_cierre_inscripcion)
		diferencia_segundos_cierre_inscripcion_y_hoy=fecha_cierre_inscripcion.to_i - Time.new.to_i
		formatoCuentaRegresiva=""

		if diferencia_segundos_cierre_inscripcion_y_hoy >= (60 * 60 * 24) then
			diferenciaDias = (diferencia_segundos_cierre_inscripcion_y_hoy / 60 / 60 / 24 ) 
			diferencia_segundos_cierre_inscripcion_y_hoy = diferencia_segundos_cierre_inscripcion_y_hoy - (diferenciaDias * 24 * 60 * 60 )
			formatoCuentaRegresiva = diferenciaDias.to_s + "d"
		end

		if diferencia_segundos_cierre_inscripcion_y_hoy > (60 * 60) then
			if formatoCuentaRegresiva != "" then 
				formatoCuentaRegresiva+=" "
			end	
			difrenciaHoras = (diferencia_segundos_cierre_inscripcion_y_hoy / 60 / 60   )			
			diferencia_segundos_cierre_inscripcion_y_hoy = diferencia_segundos_cierre_inscripcion_y_hoy - (difrenciaHoras * 60 * 60 )
			formatoCuentaRegresiva += difrenciaHoras.to_s + "h"
		end
		
		if diferencia_segundos_cierre_inscripcion_y_hoy > 60 then
			if formatoCuentaRegresiva != "" then 
				formatoCuentaRegresiva+=" "
			end	
			diferenciaMinutos = diferencia_segundos_cierre_inscripcion_y_hoy / 60 
			diferencia_segundos_cierre_inscripcion_y_hoy = diferencia_segundos_cierre_inscripcion_y_hoy - (diferenciaMinutos * 60  )
			formatoCuentaRegresiva += diferenciaMinutos.to_s + "m"
		end

		if diferencia_segundos_cierre_inscripcion_y_hoy > 0 then
			if formatoCuentaRegresiva != "" then 
				formatoCuentaRegresiva+=" "
			end	
			formatoCuentaRegresiva += (diferencia_segundos_cierre_inscripcion_y_hoy ).to_s + "s"
		end

		return formatoCuentaRegresiva
	end

end
