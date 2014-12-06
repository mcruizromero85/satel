class Ronda < ActiveRecord::Base
  validates :inicio_fecha, presence: { message: ', las fechas de las rondas no pueden estar vacias' }
  validates :inicio_tiempo, presence: { message: ', las horas de las rondas no pueden estar vacias' }

  belongs_to :torneo
  has_many :encuentros, -> { order('posicion_en_ronda ASC') }, autosave: false

  def inicio_ronda
    fecha = inicio_fecha
    tiempo = inicio_tiempo
    Time.local(fecha.year, fecha.month, fecha.day, tiempo.hour, tiempo.min, tiempo.sec)
  end

  def inicializar_valores_por_defecto(numero)
    self.numero = numero
    self.inicio_fecha = Time.new + (60 * 60 * numero)
    self.inicio_tiempo = Time.new + (60 * 60 * numero)
    self.modo_ganar = 1
  end

  def armar_encuentros_con_gamers_confirmados(gamers_emparejados)
    contador_gamer = 1
    contador_posicion_en_ronda = 1
    gamera = nil
    encuentros.destroy_all
    gamers_emparejados.each do | gamer |
      if contador_gamer.even?
        encuentro = Encuentro.new(gamerinscritoa: gamera, gamerinscritob: gamer, posicion_en_ronda: contador_posicion_en_ronda)
        encuentros << encuentro
        contador_posicion_en_ronda += 1
      else
        gamera = gamer
      end
      contador_gamer += 1
    end

    return unless contador_gamer.even?
    encuentro = Encuentro.new
    encuentro.gamerinscritoa = gamera
    encuentro.posicion_en_ronda = contador_posicion_en_ronda
    encuentros << encuentro
    contador_posicion_en_ronda += 1
  end
end
