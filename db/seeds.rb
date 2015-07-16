# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Juego.count == 0
	Juego.create(nombre: "Dota2",nombre_imagen: "dota2.jpg" ,descripcion: "Dota2", tipo_juego: 0)
	Juego.create(nombre: "Heroes of The Storm", nombre_imagen:"hots.jpg", descripcion: "Heroes of The Storm", tipo_juego: 0)
	Juego.create(nombre: "League of Legends", nombre_imagen: "lol.jpg", descripcion: "League of Legends", tipo_juego: 0)
	Juego.create(nombre: "Smite", nombre_imagen: "smite.png", descripcion: "Smite", tipo_juego: 0)
	Juego.create(nombre: "Otros", nombre_imagen: "otros.jpg", descripcion: "Otros", tipo_juego: 0)
	Juego.create(nombre: "Heroes of the Storm", nombre_imagen: "destacado_ligamagma_hots.png", descripcion: "Heroes of the Storm", tipo_juego: 1)
	Juego.create(nombre: "Hearthstone", nombre_imagen: "destacado_ligamagma_hs.png", descripcion: "Hearthstone", tipo_juego: 1)

	16.times do | contador |
		numero = contador + 1
		Gamer.create(nombres: 'Free win ' + numero.to_s, nick: 'Free win ' + numero.to_s, correo: 'Free win ' + numero.to_s + '@freewin.com')	
	end
end

Inscripcion.all.each do | inscripcion |	
	if !inscripcion.hots_formulario.nil?
		inscripcion.etiqueta_llave = inscripcion.hots_formulario.nombre_equipo
  	inscripcion.etiqueta_chat = inscripcion.hots_formulario.capitan_nick + '(' + inscripcion.hots_formulario.nombre_equipo + ')'
  	inscripcion.save
  end
end