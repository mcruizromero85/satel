FLAG_INSCRIPCIONES_NO_DISPONIBLES = 0
FLAG_INSCRIPCIONES_DISPONIBLES = 0
if ENV["RAILS_ENV"] == 'production'
	URL_CANCELAR_PAYPAL = "http://www.ggesports.la/inscripciones/new/" 
	URL_RETORNO_PAYPAL = "http://www.ggesports.la/inscripciones/confirmar/"
else
	URL_CANCELAR_PAYPAL = "http://localhost:3000/inscripciones/new/"
	URL_RETORNO_PAYPAL = "http://localhost:3000/inscripciones/confirmar/"
end

