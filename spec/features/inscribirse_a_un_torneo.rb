require 'spec_helper'
require 'util_tests'

feature 'Inscribirse a un torneo' do
  before :each do
    @torneo = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10, juego: Juego.find_by(nombre: "Hearthstone"))
    @torneo_con_inscritos = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 10, juego: Juego.find_by(nombre: "Hearthstone"))
    @torneo_ya_finalizado = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new - 30, juego: Juego.find_by(nombre: "Hearthstone"), force_submit: true )
    16.times do
      inscripcion = FactoryGirl.create(:inscripcion, torneo: @torneo_con_inscritos)
    end
  end

  scenario 'Dado que el usuario ingresó su battletag y correo correctamente, entonces debe aparecer el mensaje “Tu inscripción se guardó satisfactoriamente” en la pantalla de ficha de torneo' do
  	autenticarse_como_gamer
  	visit "/inscripciones/new?id_torneo=" + @torneo.id.to_s
  	fill_in 'email', with: 'user@example.com'
    fill_in 'battletag', with: 'Kripty#1234'
  	click_button('Inscribirme')
  	expect(page).to have_content('Tu inscripción se guardó satisfactoriamente')
  end

  scenario 'Dado que el usuario ingresó un battletag incorrecto, entonces le debe aparecer el mensaje “El battle tag debe tener el formato nick#1234"' do
  	autenticarse_como_gamer
  	visit "/inscripciones/new?id_torneo=" + @torneo.id.to_s
  	fill_in 'email', with: 'user@example.com'
	fill_in 'battletag', with: '1234'
  	click_button('Inscribirme')
  	expect(page).to have_content('El battle tag debe tener el formato nick#1234')
  	#find("#inscribir_torneo_" + @torneo.id.to_s).click
    #click_button('Inscribirme')    
    #autenticarse_como_organizador
    #registrar_torneo    
    #inscribirme_al_torneo
    #expect(page).to have_content('Tu Inscripción se realizó con éxito')
  end

  scenario 'Dado que el usuario ingresó un correo incorrecto, entonces le debe aparecer el mensaje “Tu correo no tiene el formato correcto"' do
  	autenticarse_como_gamer
  	visit "/inscripciones/new?id_torneo=" + @torneo.id.to_s
  	fill_in 'email', with: 'userexample.com'
    fill_in 'battletag', with: 'Kripty#1234'
  	click_button('Inscribirme')
  	expect(page).to have_content('Tu correo no tiene el formato correcto')
  end

  scenario 'Dado que un torneo ya cubrió todas sus vacantes, entonces al inscribirse el mensaje que debe salir es “Tu inscripción se guardó satisfactoriamente, pero estás en cola, tu posición es “x” en la pantalla de ficha de producto. X representa la posición que obtuvo' do
    autenticarse_como_gamer
    visit "/inscripciones/new?id_torneo=" + @torneo_con_inscritos.id.to_s
    fill_in 'email', with: 'user@example.com'
    fill_in 'battletag', with: 'Kripty#1234'
    click_button('Inscribirme')    
    expect(page).to have_content('Tu inscripción se guardó satisfactoriamente, pero estás en cola, tu posición es 17')
  end

  scenario 'Dado que un torneo ya culminó su fase de inscripciones, entonces al intentar inscribirse a dicho torneo, el sistema mostrará el mensaje “Las inscripciones ya cerraron para el torneo, volver”, la palabra volver linkeará a la portada' do
    autenticarse_como_gamer
    visit "/inscripciones/new?id_torneo=" + @torneo_ya_finalizado.id.to_s
    fill_in 'email', with: 'user@example.com'
    fill_in 'battletag', with: 'Kripty#1234'
    click_button('Inscribirme')    
    expect(page).to have_content('Las inscripciones ya cerraron para el torneo, volver')
  end

  scenario 'Dado que un Gamer ya se inscribió a un torneo, entonces al intentar inscribirse nuevamente, el sistema mostrará el mensaje “Ya estás inscrito al torneo, espera la fase de confirmación”.' do
    autenticarse_como_gamer
    visit "/inscripciones/new?id_torneo=" + @torneo.id.to_s
    fill_in 'email', with: 'user@example.com'
    fill_in 'battletag', with: 'Kripty#1234'
    click_button('Inscribirme')
    visit "/inscripciones/new?id_torneo=" + @torneo.id.to_s
	fill_in 'email', with: 'user@example.com'
    fill_in 'battletag', with: 'Kripty#1234'
    click_button('Inscribirme')
    expect(page).to have_content('Ya estás inscrito al torneo, espera la fase de confirmación')
  end
end


