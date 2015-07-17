class Torneo < ActiveRecord::Base
  validates :titulo, presence: { message: ', el título es un dato obligatorio' }
  validates :cierre_inscripcion, presence: { message: ', la fecha de cierre de inscripciones tiene que ser mayor a la actual' }
  validates :titulo, length: {
    minimum: 30,
    maximum: 100,
    too_short: ', el título debe estar entre 30 y 100 caracteres',
    too_long: ', el título debe estar entre 30 y 100 caracteres'
  }
  validates :urlstreeming, presence: { message: ', El canal de streeming no se ha definido' }
  #validates :urlstreeming, format: { with: URI.regexp(%w(http https)), message: ', Debe tener el formato de una url, incluido http / https' }
  validate :fecha_cierre_mayor_que_actual
  validate :fecha_registro_entre_rondas
  #validate :ronda_numero_uno_mayor_fecha_inscripcion
  validate :cantidad_minima_confirmados
  validates :periodo_confirmacion_en_minutos, numericality: true
  belongs_to :gamer
  belongs_to :juego, autosave: false
  has_many :rondas, -> { order('numero ASC') }, autosave: true
  has_many :inscripciones, -> { where "(tipo_inscripcion != 0 or tipo_inscripcion is null)" }, autosave: true  
  before_save :asignar_valores_por_defectos, if: "estado == 'Creado'"
  has_one :detalle_pago_inscripcion, autosave: true

  def asignar_valores_por_defectos
    numero_de_rondas_totales = TorneosHelper.obtener_rondas_por_vacantes(vacantes)
    rondas.destroy_all
    numero_de_rondas_totales.times do | numero |
      ronda = Ronda.new
      ronda.inicializar_valores_por_defecto(numero + 1, cierre_inscripcion)
      agregar_ronda(ronda)
    end    
  end

  def rondas_existentes_por_vacantes
    return unless rondas.size != TorneosHelper.obtener_rondas_por_vacantes(vacantes)
    errors.add(:rondas, ', todas las rondas deben estar definidas')
  end

  def self.obtener_torneos_iniciados(gamer_logeado)
    Torneo.joins(:inscripciones).where('torneos.estado = :estado and inscripciones.gamer_id = :gamer_id and inscripciones.estado = :estado_inscripcion ', gamer_id: gamer_logeado.id, estado_inscripcion: 'Confirmado', estado: 'Iniciado').order(clasificacion: :asc, cierre_inscripcion: :asc)
  end

  def self.obtener_torneos_ya_confirmados(gamer_logeado)
    Torneo.joins(:inscripciones).where('torneos.estado = :estado and inscripciones.gamer_id = :gamer_id and inscripciones.estado = :estado_inscripcion ', gamer_id: gamer_logeado.id, estado_inscripcion: 'Confirmado', estado: 'Creado').order(clasificacion: :asc, cierre_inscripcion: :asc)
  end

  def self.obtener_torneos_ya_inscrito(gamer, flag_pago_inscripciones=0)
    Torneo.joins(:inscripciones).where('torneos.flag_pago_inscripciones = :flag_pago_inscripciones and torneos.cierre_inscripcion > :fecha_actual and inscripciones.gamer_id = :gamer_id and inscripciones.estado in(:estado, :estado)', fecha_actual: Time.new, gamer_id: gamer.id, estado: 'Inscrito', flag_pago_inscripciones: flag_pago_inscripciones).order(clasificacion: :asc, cierre_inscripcion: :asc)
  end

  def self.obtener_torneos_disponibles_para_inscribir(ids_torneos_inscritos_y_confirmados = [-1])
    Torneo.all.order(clasificacion: :asc, cierre_inscripcion: :asc).limit(20).where('cierre_inscripcion > :fecha_actual and id not in (:ids_torneos_inscritos_y_confirmados)', fecha_actual: Time.new, ids_torneos_inscritos_y_confirmados: ids_torneos_inscritos_y_confirmados)
  end

  def agregar_ronda(ronda)
    return unless ronda.valid?
    if rondas.size > 0
      rondas[rondas.size - 1].ronda_siguiente = ronda
      rondas[rondas.size - 1].save
    end
    rondas << ronda
  end

  def fecha_y_hora_inscripcion(fecha, hora)
    fecha = Date.strptime(fecha, '%d/%m/%Y')
    hora = Time.strptime(hora, '%I:%M %p')
    self.cierre_inscripcion = Time.new(fecha.year, fecha.month, fecha.day, hora.hour, hora.min, hora.sec,"-05:00")
    rescue StandardError
      errors.add(:cierre_inscripcion, ', la fecha debe estar en formato dd/mm/yyyy')
      errors.add(:cierre_inscripcion, ', , la hora debe estar en formato hh:mm AM/PM')
  end

  def cantidad_minima_confirmados
    cantidad_confirmados = Inscripcion.inscripciones_permitidas_y_confirmadas_en_el_torneo(self).size
    return unless estado == 'Iniciado' && cantidad_confirmados < 4
    errors.add(:vacantes, ', El Torneo debe tener como mínimo 4 gamers confirmados')
  end

  def inicio_fecha_hora_confirmacion
    cierre_inscripcion - (periodo_confirmacion_en_minutos * 60)
  end

  def fecha_cierre_mayor_que_actual
    return unless estado == 'Creado'
    return unless (cierre_inscripcion - Time.new) < 0
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

  def generar_encuentros(flag_aleatorio = true)
    return unless estado != 'Iniciado'
    rondas.each do | ronda |
      ronda.encuentros.destroy_all
    end
    Inscripcion.destroy_all(tipo_inscripcion: 0, torneo: self)
    array_inscritos_confirmados = Inscripcion.inscripciones_confirmadas_permitidas_con_free_wins(self,flag_aleatorio)
    rondas.where(numero: 1).first.armar_encuentros_con_confirmados(array_inscritos_confirmados)
    reload
  end

  def arreglo_de_nombres_para_llaves(flag_aleatorio = true)
    array_para_llaves = '['
    contador = 1
    rondas.where(numero: 1).first.encuentros.each do | encuentro |
      if !encuentro.gamerinscritoa.nil?
        array_para_llaves.concat("[\"" + encuentro.gamerinscritoa.etiqueta_llave + "\",")
      else
        array_para_llaves.concat("[\"\",")
      end

      if !encuentro.gamerinscritob.nil?
        array_para_llaves.concat("\"" + encuentro.gamerinscritob.etiqueta_llave + "\"]")
      else
        array_para_llaves.concat("\"\"]")
      end

      if rondas.where(numero: 1).first.encuentros.count != contador
        array_para_llaves.concat(',')
      end
      contador += 1
    end
    array_para_llaves.concat(']')
    array_para_llaves
  end
end
