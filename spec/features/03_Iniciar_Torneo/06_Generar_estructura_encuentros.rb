require "spec_helper"
require "util_tests"

feature "Iniciar Torneo" do

	scenario "Dado que registre un torneo para 8 vacantes y tengo 8 confirmados, entonces debería poder iniciar el torneo", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers		
		iniciar_torneo		
		expect(page).to have_content("Torneo en Curso")
	end

	scenario "Dado que registre un torneo para 8 vacantes y tengo 8 confirmados, entonces no debería ver la opción Volver a Generar e Iniciar Torneo", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers		
		iniciar_torneo		
		expect(page).not_to have_content("Volver a generar")
		expect(page).not_to have_content("Iniciar Torneo!!!")
	end

	scenario "Dado que registre un torneo para 8 vacantes y tengo 4 confirmados, entonces debería poder iniciar el torneo", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers 4				
		iniciar_torneo
		expect(page).to have_content("Torneo en Curso")		
	end

	scenario "Dado que registre un torneo para 8 vacantes y tengo 3 confirmados, entonces no debería poder iniciar el torneo", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers 3		
		iniciar_torneo
		expect(page).to have_content("El Torneo debe tener como mínimo 4 gamers confirmados")		
	end

	scenario "Dado que registre un torneo para 8 vacantes y tengo 10 confirmados, entonces debería generar las llaves con los 8 primeros", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers 10		
		iniciar_torneo
		expect(page).to have_content("Torneo en Curso")
	end

	def iniciar_torneo
		autenticarse_como_organizador
		click_link('link_mis_torneos')
		click_link('link_iniciar_torneo_'+@id_torneo_registrado)		
		click_button('Iniciar Torneo!!!')		
	end

end
