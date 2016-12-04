require 'spec_helper'
require 'util_tests'

feature 'Ficha de torneo' do
  before :all do
  	@authentication = FactoryGirl.create(:authentication)
    @torneo_creado = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 1200, juego: Juego.find_by(nombre: "Hearthstone"))
    @torneo_inscrito = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 12000, juego: Juego.find_by(nombre: "Hearthstone"))
    @torneo_checkin = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 12, juego: Juego.find_by(nombre: "Hearthstone"))
    @torneo_iniciado = FactoryGirl.create(:torneo, vacantes: 16, cierre_inscripcion: Time.new + 120, juego: Juego.find_by(nombre: "Hearthstone"), estado: "Iniciado")
    FactoryGirl.create(:inscripcion, gamer: @authentication.gamer, torneo: @torneo_inscrito)
    FactoryGirl.create(:inscripcion, gamer: @authentication.gamer, torneo: @torneo_checkin)
  end

  scenario 'Dado que el torneo está en estado: “Creado” entonces debo visualizar el botón "Inscribir"'  do
    autenticarse_como_gamer @authentication.gamer.correo
    within("#seccion_torneo_" + @torneo_creado.id.to_s) do
	    expect(find('button')).to have_content('Inscribir')
	  end
  end

  scenario 'Dado que ya estoy inscrito en el torneo y el estado es “Creado”, entonces debo visualizar el botón, en readonly, "Inscrito, Espera la fase de Check-In"'  do
    autenticarse_como_gamer @authentication.gamer.correo
  	within("#seccion_torneo_" + @torneo_inscrito.id.to_s) do
  	  expect(find('button')).to have_content('Inscrito, Espera la fase de Check-In')
  	end
  end

  scenario 'Dado que el torneo está en periodo de: “Check-In” entonces debo visualizar el botón "Check-In"'  do
    autenticarse_como_gamer @authentication.gamer.correo    
  	within("#seccion_torneo_" + @torneo_checkin.id.to_s) do	  
  	  expect(find('button')).not_to have_content('Inscrito, Espera la fase de Check-In')
  	  expect(find('button')).to have_content('Check-In')
  	end
  end

  scenario 'Dado que el torneo está en estado: “En Curso o Finalizado” entonces debo visualizar el botón "Ver detalle"'  do
    autenticarse_como_gamer @authentication.gamer.correo
  	within("#seccion_torneo_" + @torneo_iniciado.id.to_s) do
  	  expect(find('button')).to have_content('Ver detalle')
  	end
  end
end

