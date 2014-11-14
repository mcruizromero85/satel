class Ronda < ActiveRecord::Base
	validates_presence_of :inicio_fecha, :message => ", las fechas de las rondas no pueden estar vacias"
	validates_presence_of :inicio_tiempo, :message => ", las horas de las rondas no pueden estar vacias"
	
	belongs_to :torneo
	has_many :encuentros, autosave: false

	def inicio_ronda
		fecha=self.inicio_fecha
		tiempo=self.inicio_tiempo
		Time.local(fecha.year ,fecha.month,fecha.day,tiempo.hour,tiempo.min,tiempo.sec)
	end

	def inicializar_valores_por_defecto(numero)
				self.numero = numero
        self.inicio_fecha=Time.new + (60 * 60 * numero)
        self.inicio_tiempo=Time.new + (60 * 60 * numero)
        self.modo_ganar = 1          
  end

  def armar_encuentros_con_gamers_confirmados(array_gamers_confirmados_y_emparejados,cantidad_slots)
  	contador_gamer=1
  	contador_posicion_en_ronda=1
  	gamera = nil

  	self.encuentros.destroy_all

  	array_gamers_confirmados_y_emparejados.each do | gamer |
  		if contador_gamer % 2 == 0   			
	    	encuentro = Encuentro.new
	    	encuentro.gamera=gamera
	    	encuentro.gamerb=gamer
	    	encuentro.posicion_en_ronda=contador_posicion_en_ronda
	    	self.encuentros << encuentro
	    	contador_posicion_en_ronda=contador_posicion_en_ronda+1
  		else
  			gamera=gamer
  		end
  		contador_gamer = contador_gamer + 1
  	end

  	if contador_gamer % 2 == 0
  		encuentro = Encuentro.new
	    encuentro.gamera=gamera	    
	    encuentro.posicion_en_ronda=contador_posicion_en_ronda
	    self.encuentros << encuentro
	    contador_posicion_en_ronda=contador_posicion_en_ronda+1
  	end

  	total_de_encuentros_que_deberian_existir=cantidad_slots/2

  	if total_de_encuentros_que_deberian_existir > self.encuentros.count 
  		encuentros_vacios_faltantes=total_de_encuentros_que_deberian_existir-self.encuentros.count

  		for encuentro_vacio in 1..encuentros_vacios_faltantes
				encuentro = Encuentro.new
		    encuentro.posicion_en_ronda=contador_posicion_en_ronda
		    self.encuentros << encuentro
		    contador_posicion_en_ronda=contador_posicion_en_ronda+1
    	end

  	end


  end

end
