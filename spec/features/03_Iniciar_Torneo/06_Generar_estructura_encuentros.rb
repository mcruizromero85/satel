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
		page.save_screenshot('Inscritos.png')
	end

	def inscribir_y_confirmar_gamers cantidad_inscritos_confirmados=8

		array_gamers_ejemplo = Array.new
		array_gamers_ejemplo << "Mauro"
		array_gamers_ejemplo << "Mateo"
		array_gamers_ejemplo << "EddyArn"
		array_gamers_ejemplo << "Brucefulus"
		array_gamers_ejemplo << "Locopiedra"
		array_gamers_ejemplo << "Sivicious"
		array_gamers_ejemplo << "Otaru"
		array_gamers_ejemplo << "Gianella"
		array_gamers_ejemplo << "Sonny"
		array_gamers_ejemplo << "Kodo"

		array_gamers_a_inscribirse=array_gamers_ejemplo.sample(cantidad_inscritos_confirmados)	

		array_gamers_a_inscribirse.each do | nombre_gamer | 
			inscribirse_como(nombre_gamer,nombre_gamer.downcase + "gmail.com")
		end					
	end

	def registrar_torneo
		llenar_formulario_con_datos_correctos 30
		click_button("Registrar Torneo")
		@id_torneo_registrado=find('#id_torneo_registrado').text				
		click_link('link_cerrar_sesion')		
	end

	def inscribirse_como(nombre,correo)
		visit "/"
		click_link("autenticarse")
		fill_in("name", :with => nombre)
		fill_in("email", :with => correo)
		click_button("autenticar")
		click_link('link_inscripcion_torneo_'+@id_torneo_registrado)
		click_button("Inscribirme")
		visit "/"			
		click_link('link_confirmar_torneo_'+@id_torneo_registrado)		
		click_link('link_cerrar_sesion')
	end

	def iniciar_torneo
		autenticarse_como_organizador
		click_link('link_mis_torneos')
		click_link('link_iniciar_torneo_'+@id_torneo_registrado)		
		click_button('Iniciar Torneo!!!')		
	end

end
