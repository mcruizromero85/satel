class Ronda < ActiveRecord::Base
  validates :inicio_fecha, presence: { message: ', las fechas de las rondas no pueden estar vacias' }
  validates :inicio_tiempo, presence: { message: ', las horas de las rondas no pueden estar vacias' }
  belongs_to :ronda_siguiente, class_name: 'Ronda'
  belongs_to :torneo
  has_many :encuentros, -> { order('posicion_en_ronda ASC') }, autosave: false

  def inicio_ronda
    fecha = inicio_fecha
    tiempo = inicio_tiempo
    Time.local(fecha.year, fecha.month, fecha.day, tiempo.hour, tiempo.min, tiempo.sec)
  end

  def inicializar_valores_por_defecto(numero, cierre_inscripcion)
    self.numero = numero
    self.inicio_fecha = cierre_inscripcion + (60 * 60 * numero)
    self.inicio_tiempo = cierre_inscripcion + (60 * 60 * numero)
    self.modo_ganar = 1
  end

  def armar_encuentros_con_confirmados(gamers)
    contador_gamer = 1
    contador_posicion_en_ronda = 1
    gamera = nil
    gamers.each do | gamer |
      if contador_gamer.even?
        encuentro = Encuentro.new(gamerinscritoa: gamera, gamerinscritob: gamer, posicion_en_ronda: contador_posicion_en_ronda)
        encuentros << encuentro
        if encuentro.gamerinscritoa.etiqueta_llave == 'Free Win'
          encuentro.gamerinscrito_ganador = encuentro.gamerinscritob
          encuentro.registrar_ganador(true)
        end

        if encuentro.gamerinscritob.etiqueta_llave == 'Free Win'
          encuentro.gamerinscrito_ganador = encuentro.gamerinscritoa
          encuentro.registrar_ganador(true)
        end
        contador_posicion_en_ronda += 1
      else
        gamera = gamer
      end
      contador_gamer += 1
    end

    return unless contador_gamer.even?
    encuentro = Encuentro.new(gamerinscritoa: gamera, posicion_en_ronda: contador_posicion_en_ronda)
    encuentros << encuentro
  end
end
