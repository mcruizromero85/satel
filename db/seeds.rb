# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Juego.create(nombre: "Dota2",nombre_imagen: "dota2.jpg" ,descripcion: "Dota2")
Juego.create(nombre: "Heroes of The Storm", nombre_imagen:"hots.jpg", descripcion: "Heroes of The Storm")
Juego.create(nombre: "League of Legends", nombre_imagen: "lol.jpg", descripcion: "League of Legends")
Juego.create(nombre: "Smite", nombre_imagen: "smite.png", descripcion: "Smite")
Juego.create(nombre: "Otros", nombre_imagen: "otros.jpg", descripcion: "Otros")
16.times do | contador |
	numero = contador + 1
	Gamer.create(nombres: 'Free win ' + numero.to_s, nick: 'Free win ' + numero.to_s, correo: 'Free win ' + numero.to_s + '@freewin.com')	
end
