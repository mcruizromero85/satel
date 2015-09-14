class Juego < ActiveRecord::Base
  has_many :torneos

  def self.juegos_disponibles
    Juego.where('tipo_juego = :tipo_juego ', tipo_juego: 0)
  end
end
