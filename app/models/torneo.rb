class Torneo < ActiveRecord::Base
	validates_presence_of :titulo, :message => ", el título es un dato obligatorio" 
	validates_length_of :titulo, :within => 30..100, :message => ", el título debe estar entre 30 y 100 caracteres"
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

	def self.obtener_torneos_iniciados(gamer_logeado)
		Torneo.joins(:inscripciones).where("torneos.estado = :estado_iniciado_torneo and inscripciones.gamer_id = :gamer_id and inscripciones.estado = :estado ",{gamer_id: gamer_logeado.id, estado: "Confirmado", estado_iniciado_torneo: "Iniciado" }).order(cierre_inscripcion: :asc)
	end

	def self.obtener_torneos_ya_confirmados(gamer_logeado)
		Torneo.joins(:inscripciones).where("torneos.estado = :estado_esperado_torneo and inscripciones.gamer_id = :gamer_id and inscripciones.estado = :estado ",{gamer_id: gamer_logeado.id, estado: "Confirmado", estado_esperado_torneo: "Creado" }).order(cierre_inscripcion: :asc)
	end

	def self.obtener_torneos_ya_inscrito(gamer_logeado)
		Torneo.joins(:inscripciones).where("torneos.cierre_inscripcion > :fecha_actual and inscripciones.gamer_id = :gamer_id and inscripciones.estado = :estado ",{fecha_actual: Time.new, gamer_id: gamer_logeado.id, estado: "No confirmado" }).order(cierre_inscripcion: :asc)
	end

	def self.obtener_torneos_disponibles_para_inscribir(ids_torneos_inscritos_y_confirmados)
		Torneo.all.order(cierre_inscripcion: :asc).limit(20).where("cierre_inscripcion > :fecha_actual and id not in (:ids_torneos_inscritos_y_confirmados) ",{fecha_actual: Time.new, ids_torneos_inscritos_y_confirmados: ids_torneos_inscritos_y_confirmados })
	end

	def agregar_ronda(ronda)

		if ronda.valid?
      self.rondas << ronda
    end
	end

	def inicializar_valores_por_defecto
	  self.vacantes=8
    self.cierre_inscripcion = (Time.new + (60 * 60 * 0.5))           

    numero_de_rondas_totales=TorneosHelper.obtener_rondas_por_vacantes(self.vacantes)

    for numero in 1..numero_de_rondas_totales
        ronda=Ronda.new
        ronda.inicializar_valores_por_defecto(numero)        
        agregar_ronda(ronda)
    end
	end

	def fecha_y_hora_inscripcion(fecha,hora)
		fecha=Date.strptime(fecha, "%d/%m/%Y") rescue nil
		hora=Time.strptime(hora, "%I:%M %p") rescue nil
		if fecha == nil
			errors.add(:cierre_inscripcion, ", la fecha debe estar en formato dd/mm/yyyy")
			return
		end
		
		if hora == nil
			errors.add(:cierre_inscripcion, ", , la hora debe estar en formato hh:mm AM/PM")
			return
		end
		self.cierre_inscripcion=Time.local(fecha.year ,fecha.month,fecha.day,hora.hour,hora.min,hora.sec)
	end

	def cantidad_minima_confirmados
		cantidad_confirmados=Gamer.joins(:inscripciones).where("inscripciones.torneo_id = :torneo_id and inscripciones.estado = :estado" , torneo_id: self.id, estado: "Confirmado").count
		if self.estado == "Iniciado" and cantidad_confirmados < 4
		      errors.add(:vacantes, ", El Torneo debe tener como mínimo 4 gamers confirmados")
		end 
	end

	def inicio_fecha_hora_confirmacion			
		cierre_inscripcion - (periodo_confirmacion_en_minutos * 60)
	end

	def fecha_cierre_mayor_que_actual
		if self.estado == "Creado"
		    if (cierre_inscripcion.to_i - Time.new.to_i) < 0 then 
		      errors.add(:cierre_inscripcion, ", la fecha de cierre de inscripciones tiene que ser mayor a la actual")
		    end
		end
  	end

  	def ronda_numero_uno_mayor_fecha_inscripcion
  		if rondas.size > 0 then
			if ( rondas[0].inicio_ronda.to_i - cierre_inscripcion.to_i) < 0 then 
				errors.add(:cierre_inscripcion, ", la fecha de la primera ronda debe ser mayor a la fecha de cierre de inscripcion")
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
		if self.estado != "Iniciado"
			array_gamers_confirmados = Gamer.joins(:inscripciones).where("inscripciones.torneo_id = :torneo_id and inscripciones.estado = :estado" , torneo_id: self.id, estado: "Confirmado").limit(self.vacantes).order('inscripciones.id')
			cantidad_slots=obtener_cantidad_de_slots_segun_gamers_confirmados(array_gamers_confirmados.count)
			array_gamers_confirmados_y_emparejados=array_gamers_confirmados.sample(cantidad_slots)
			self.rondas.first.armar_encuentros_con_gamers_confirmados(array_gamers_confirmados_y_emparejados,cantidad_slots)
		end
	end

	private    
    def obtener_cantidad_de_slots_segun_gamers_confirmados(gamers_confirmados)
      if gamers_confirmados <= 4 
      	4
      elsif gamers_confirmados <= 8
      	8
      elsif gamers_confirmados <= 16
      	16
      elsif gamers_confirmados <= 32
      	32
      else
      	64
      end
    end

end
