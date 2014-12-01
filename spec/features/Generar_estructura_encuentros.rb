require "spec_helper"
require "util_tests"

feature "Iniciar Torneo" do


	scenario "Dado que me inscribe a un torneo de 8 vacantes y lo iniciaron con 4 confirmados, entonces debería ver 'Torneo en curso' en la portada", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers 3
		autenticarse_como_gamer #Gamer que si se que id tiene, los 3 anteriores son aleatorios
		inscribirme_y_confirmar
		autenticarse_como_organizador
		iniciar_torneo
		click_link('link_cerrar_sesion')
		autenticarse_como_gamer 
		expect(page).to have_content("Torneo Iniciado!!!")
		visit "/"
		expect(page).to have_content("Torneo Iniciado!!!")
	end

	scenario "Dado que registre un torneo para 8 vacantes y tengo 4 confirmados, entonces debería poder iniciar el torneo", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers 4	
		autenticarse_como_organizador			
		iniciar_torneo
		expect(page).not_to have_content("Volver a generar")
		expect(page).not_to have_content("Iniciar Torneo!!!")	
	end

	scenario "Dado que registre un torneo para 8 vacantes y tengo 1 confirmado, entonces no debería poder iniciar el torneo", :js => true do
		autenticarse_como_organizador
		registrar_torneo		
		inscribir_y_confirmar_gamers 1	
		autenticarse_como_organizador			
		iniciar_torneo
		expect(page).to have_content("El Torneo debe tener como mínimo 4 gamers confirmados")
	end

	def inscribirme_y_confirmar
		click_link('link_inscripcion_torneo_'+@id_torneo_registrado)
		click_button("Inscribirme")		
		visit "/"			
		click_link('link_confirmar_torneo_'+@id_torneo_registrado)	
		visit "/"
		click_link('link_cerrar_sesion')
	end

	def iniciar_torneo
		click_link('link_mis_torneos')
		click_link('link_iniciar_torneo_'+@id_torneo_registrado)		
		click_button('Iniciar Torneo!!!')	
	end

end
