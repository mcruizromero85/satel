class TorneoView
	attr_accessor :listado_torneos,:data_inicial_para_registro,:torneo_detallado,:lista_juegos
	@listado_torneos	
	@data_inicial_para_registro
	@torneo_detallado
	@lista_juegos
	
	def inicializar_datos_de_torneo_nuevo
		@data_inicial_para_registro = Torneo.new
	    @data_inicial_para_registro.vacantes=8
	    @data_inicial_para_registro.cierre_inscripcion_fecha = (Time.new + (60 * 60 * 0.5)).to_date
	    @data_inicial_para_registro.cierre_inscripcion_tiempo = Time.new + ((60 * 60 * 0.5))	        	

	    numero_de_rondas_totales=TorneosHelper.obtener_rondas_por_vacantes(@data_inicial_para_registro.vacantes)

    	for i in 1..numero_de_rondas_totales
	        ronda=Ronda.new
	        ronda.numero = i
	        ronda.inicio_fecha=Time.new + (60 * 60 * ronda.numero)
	        ronda.inicio_tiempo=Time.new + (60 * 60 * ronda.numero)
	        if i == numero_de_rondas_totales then
	        	ronda.modo_ganar = 5
	        else
	        	ronda.modo_ganar = 1	
	        end

	        
	        @data_inicial_para_registro.rondas << ronda
	    end
  	end

  	def mostrar_html_filas_por_rondas
  		
  	end
end