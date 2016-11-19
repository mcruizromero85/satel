require 'spec_helper'
require 'util_tests'

feature 'Generar llaves' do
  before :each do
    @gamer_organizador = FactoryGirl.create(:gamer, correo: "gcarhuamacaquispe@gmail.com")
    @torneo = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new - 10, juego: Juego.find_by(nombre: "Hearthstone"), gamer: @gamer_organizador)
    16.times do
      inscripcion = FactoryGirl.create(:inscripcion, torneo: @torneo_con_inscritos)
    end
  end

  scenario 'Dado que un torneo ya superó su fecha de cierre entonces el organizador debería ver el botón generar llaves en el listado de torneos.' do
  	autenticarse_como_organizador
  	visit "/inscripciones/new?id_torneo=" + @torneo.id.to_s
  	fill_in 'email', with: 'user@example.com'
    fill_in 'battletag', with: 'Kripty#1234'
  	click_button('Inscribirme')
  	expect(page).to have_content('Tu inscripción se guardó satisfactoriamente')
  end

end

#Dado que un torneo ya superó su fecha de cierre entonces el organizador debería ver el botón generar llaves en el listado de torneos.
#Dado que el organizador seleccionó generar llaves, entonces debería ver la pantalla de generación de llaves.
#Dado que se carga la página de generación de llaves, el organizador debe visualizar la primera generación aleatoria.
#Dado que el número de gamers confirmados al torneo es mayor a la cantidad de vacantes, se generará la llave solo con los primeros confirmados.
#Dado que el número de gamers confirmados al torneo es menor a la cantidad de vacantes, se generará free wins aleatoriamente.
