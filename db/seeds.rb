# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Juego.count == 0
	Juego.create(nombre: "Dota2",descripcion: "Dota2", tipo_juego: 0)
	Juego.create(nombre: "Heroes of The Storm", descripcion: "Heroes of The Storm", tipo_juego: 0)
	Juego.create(nombre: "League of Legends", descripcion: "League of Legends", tipo_juego: 0)
	Juego.create(nombre: "Smite", descripcion: "Smite", tipo_juego: 0)
	Juego.create(nombre: "Otros", descripcion: "Otros", tipo_juego: 0)
	Juego.create(nombre: "Heroes of the Storm", descripcion: "Heroes of the Storm", tipo_juego: 1)
	Juego.create(nombre: "Hearthstone", descripcion: "Hearthstone", tipo_juego: 1)

	16.times do | contador |
		numero = contador + 1
		Gamer.create(nombres: 'Free win ' + numero.to_s, nick: 'Free win ' + numero.to_s, correo: 'Free win ' + numero.to_s + '@freewin.com')	
	end
end

#Inscripcion.all.each do | inscripcion |	
#	if !inscripcion.hots_formulario.nil?
#		inscripcion.etiqueta_llave = inscripcion.hots_formulario.nombre_equipo
#  	inscripcion.etiqueta_chat = inscripcion.hots_formulario.capitan_nick + '(' + inscripcion.hots_formulario.nombre_equipo + ')'
#  	inscripcion.save
#  end
#end

#Datos para nuevo torneo Starcraft2
#Juego.create(nombre: "Starcraft 2", nombre_imagen:"starcraft2.jpg", descripcion: "Starcraft 2", tipo_juego: 0)

#Sponsor.create(torneo_id: Torneo.maximum('id'),logo: 'Auspiciador1.png' )
#Sponsor.create(torneo_id: Torneo.maximum('id'),logo: 'Auspiciador2.png' )
#Sponsor.create(torneo_id: Torneo.maximum('id'),logo: 'Auspiciador3.png' )

torneo = Torneo.new
torneo.titulo = "Torneo Magma Hearthstone League Bronce 1"
torneo.post_detalle_torneo = "https://www.facebook.com/magmaleague/photos/a.887764491262474.1073741828.865678523471071/918953651476891/?type=3&theater"
torneo.urlstreeming = "http://www.twitch.tv/kriptysc"
torneo.vacantes = 16
torneo.cierre_inscripcion = Time.new + (60 * 60 * 24 * 2) + 10
torneo.periodo_confirmacion_en_minutos = 20
torneo.gamer_id = 17
torneo.juego_id = 7
torneo.urllogo = "https://scontent-gru2-1.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/11210452_898572773514979_2891540801757655343_n.png?oh=9cb48e90902af1c10548d1de3e5ce198&oe=5704F5D8"
torneo.monto_auspiciado = 10.00
torneo.link_rules = "#"
torneo.estado="Creado"
torneo.save
 
