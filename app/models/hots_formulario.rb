class HotsFormulario < ActiveRecord::Base
  belongs_to :inscripcion
  validates :nombre_equipo, presence: { message: ', Colocar el nombre del equipo' }
  validates :nombre_equipo, length: {
    minimum: 5,
    maximum: 30,
    too_short: ', el nombre del equipo debe estar entre 5 y 30 caracteres',
    too_long: ', el nombre del equipo debe estar entre 5 y 30 caracteres'
  }
  validates :capitan_nick, presence: { message: ', Al menos 5 jugadores deben estar registrados' }
  validates :titular_numero1, presence: { message: ', Al menos 5 jugadores deben estar registrados' }
  validates :titular_numero2, presence: { message: ', Al menos 5 jugadores deben estar registrados' }
  validates :titular_numero3, presence: { message: ', Al menos 5 jugadores deben estar registrados' }
  validates :titular_numero4, presence: { message: ', Al menos 5 jugadores deben estar registrados' }

  validates :capitan_nick, format: { with: /\A\D.{2,11}#\d{4}\Z/, message: ', El battle tag tiene formato nick#1234' }
end
