class Torneo < ActiveRecord::Base
  validates :titulo, presence: { message: ', el título es un dato obligatorio' }
  validates :titulo, length: {
    minimum: 30,
    maximum: 100,
    too_short: ', el título debe estar entre 30 y 100 caracteres',
    too_long: ', el título debe estar entre 30 y 100 caracteres'
  }
  validates :paginaweb, format: { with: URI.regexp(%w(http https)), message: 'only allows letters' }
  validate :fecha_cierre_mayor_que_actual
  validate :fecha_registro_entre_rondas
  validate :ronda_numero_uno_mayor_fecha_inscripcion
  validate :cantidad_minima_confirmados
  validates :periodo_confirmacion_en_minutos, numericality: true
  belongs_to :gamer
  belongs_to :juego, autosave: false
  has_many :rondas, -> { order('numero ASC') }, autosave: true
  has_many :inscripciones, autosave: true
  has_many :datos_inscripciones, autosave: true
  before_save :asignar_valores_por_defectos

  def asignar_valores_por_defectos
    numero_de_rondas_totales = TorneosHelper.obtener_rondas_por_vacantes(vacantes)
    self.rondas.destroy_all
    numero_de_rondas_totales.times do | numero |
      ronda = Ronda.new
      ronda.inicializar_valores_por_defecto(numero + 1)
      agregar_ronda(ronda)
    end
  end

  def rondas_existentes_por_vacantes
    return unless rondas.size != TorneosHelper.obtener_rondas_por_vacantes(vacantes)
    errors.add(:rondas, ', todas las rondas deben estar definidas')
  end


  def self.obtener_torneos_iniciados(gamer_logeado)
    Torneo.joins(:inscripciones).where('torneos.estado = :estado and inscripciones.gamer_id = :gamer_id and inscripciones.estado = :estado_inscripcion ', gamer_id: gamer_logeado.id, estado_inscripcion: 'Confirmado', estado: 'Iniciado').order(cierre_inscripcion: :asc)
  end

  def self.obtener_torneos_ya_confirmados(gamer_logeado)
    Torneo.joins(:inscripciones).where('torneos.estado = :estado and inscripciones.gamer_id = :gamer_id and inscripciones.estado = :estado_inscripcion ', gamer_id: gamer_logeado.id, estado_inscripcion: 'Confirmado', estado: 'Creado').order(cierre_inscripcion: :asc)
  end

  def self.obtener_torneos_ya_inscrito(gamer_logeado)
    Torneo.joins(:inscripciones).where('torneos.cierre_inscripcion > :fecha_actual and inscripciones.gamer_id = :gamer_id and inscripciones.estado in (:estado_inscrito, :estado_en_revision) ', fecha_actual: Time.new, gamer_id: gamer_logeado.id, estado_inscrito: 'Inscrito', estado_en_revision: "En revisión").order(cierre_inscripcion: :asc)
  end

  def self.obtener_torneos_disponibles_para_inscribir(ids_torneos_inscritos_y_confirmados = [-1] )    
    Torneo.all.order(cierre_inscripcion: :asc).limit(20).where('cierre_inscripcion > :fecha_actual and id not in (:ids_torneos_inscritos_y_confirmados) ', fecha_actual: Time.new, ids_torneos_inscritos_y_confirmados: ids_torneos_inscritos_y_confirmados)
  end

  def agregar_ronda(ronda)
    return unless ronda.valid?
    if rondas.size > 0
      rondas[rondas.size-1].ronda_siguiente = ronda      
    end
    rondas << ronda 
  end

  def inicializar_valores
    self.estado = 'Pendiente'
    self.vacantes = 8
    self.cierre_inscripcion = (Time.new + (60 * 60 * 0.5))
  end

  def fecha_y_hora_inscripcion(fecha, hora)
    fecha = Date.strptime(fecha, '%d/%m/%Y')
    hora = Time.strptime(hora, '%I:%M %p')
    self.cierre_inscripcion = Time.local(fecha.year, fecha.month, fecha.day, hora.hour, hora.min, hora.sec)
    rescue StandardError
      errors.add(:cierre_inscripcion, ', la fecha debe estar en formato dd/mm/yyyy')
      errors.add(:cierre_inscripcion, ', , la hora debe estar en formato hh:mm AM/PM')
  end

  def cantidad_minima_confirmados
    cantidad_confirmados = Inscripcion.total_confirmados_por_torneo(self)
    return unless estado == 'Iniciado' && cantidad_confirmados < 4
    errors.add(:vacantes, ', El Torneo debe tener como mínimo 4 gamers confirmados')
  end

  def inicio_fecha_hora_confirmacion
    cierre_inscripcion - (periodo_confirmacion_en_minutos * 60)
  end

  def fecha_cierre_mayor_que_actual
    return unless estado == 'Creado'
    return unless (cierre_inscripcion.to_i - Time.new.to_i) < 0
    errors.add(:cierre_inscripcion, ', la fecha de cierre de inscripciones tiene que ser mayor a la actual')
  end

  def ronda_numero_uno_mayor_fecha_inscripcion
    return unless rondas.size > 0
    return unless (rondas[0].inicio_ronda.to_i - cierre_inscripcion.to_i) < 0
    errors.add(:cierre_inscripcion, ', la fecha de la primera ronda debe ser mayor a la fecha de cierre de inscripcion')
  end

  def fecha_registro_entre_rondas
    ronda_anterior = nil
    rondas.each do | ronda |
      if !ronda_anterior.nil? && ((ronda.inicio_ronda - ronda_anterior.inicio_ronda) < 0)
        errors.add(:rondas, ', la fecha de inicio de la ronda ' + ronda.numero.to_s + ' debe ser mayor a la ronda ' + ronda_anterior.numero.to_s)
      else
        ronda_anterior = ronda
      end
    end
  end

  def generar_encuentros
    return unless estado != 'Iniciado'
    self.rondas.each do | ronda |
      ronda.encuentros.destroy_all
    end
    array_inscritos_confirmados = Inscripcion.inscritos_confirmados_en_el_torneo_con_free_wins(self)    
    self.rondas.where(numero: 1).first.armar_encuentros_con_gamers_confirmados(array_inscritos_confirmados)
    self.reload
  end

  def agregar_dato_inscripcion(dato_inscripcion)
    self.datos_inscripciones << dato_inscripcion
  end
end
