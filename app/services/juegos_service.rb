 class JuegosService
	require 'active_support/core_ext/date'

	def self.obtener_juegos
		Juego.all.order(:nombre)
	end
end