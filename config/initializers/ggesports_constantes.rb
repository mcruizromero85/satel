TIME_OUT_LIMITE_PARA_DEBATE_DE_PARTIDA_EN_SEGUNDOS=1500
TIME_OUT_LISTO_GAMER_EN_SEGUNDOS=600
FLAG_INSCRIPCIONES_NO_DISPONIBLES = 0
FLAG_INSCRIPCIONES_DISPONIBLES = 0
ID_JUEGO_HOTS = 6
TORNEO_ESTADO_FINALIZADO = 'Finalizado'
if ENV["RAILS_ENV"] == 'production'
	URL_CANCELAR_PAYPAL = "http://www.ggesports.la/" 
	URL_RETORNO_PAYPAL = "http://www.ggesports.la/inscripciones/confirmar/"
else
	URL_CANCELAR_PAYPAL = "http://localhost:3000/"
	URL_RETORNO_PAYPAL = "http://localhost:3000/inscripciones/confirmar/"
end
