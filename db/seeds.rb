# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Juego.create(nombre: "Dota2", descripcion: "Dota2")
Juego.create(nombre: "Starcraft 2", descripcion: "Starcraft 2")
Juego.create(nombre: "League of Legends", descripcion: "League of Legends")

16.times do | contador |
	numero = contador + 1
	Gamer.create(nombres: 'Free win ' + numero.to_s, nick: 'Free win ' + numero.to_s, correo: 'Free win ' + numero.to_s + '@freewin.com')	
end