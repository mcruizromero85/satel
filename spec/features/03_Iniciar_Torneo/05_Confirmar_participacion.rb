require "spec_helper"
require "util_tests"

feature "Confirmar Participación" do

	scenario "Dado que me inscribí a un torneo y confirmo, entonces debo ver un mensaje de validación", :js => true do
		autenticarse_como_organizador
		registrar_torneo
		autenticarse_como_gamer
		inscribirme_al_torneo
		confirmar_participacion
		expect(page).to have_content("Tu confirmación se realizó con exito")
	end
	
	scenario "Dado que me inscribí a un torneo sin fase de confirmación, entonces no debería ver la opción de confirmar en el home", :js => true do
		autenticarse_como_organizador
		registrar_torneo_sin_fase_confirmacion
		autenticarse_como_gamer
		inscribirme_al_torneo
		#Para evitar código estático
		expect(page).not_to have_content("Tu posición es 9 de 8 vacantes, estás en cola")
		visit "/"
		expect(page).not_to have_content("CONFIRMAR YA!!!!")
	end

	scenario "Dado que confirmo mi participación estando en puesto 9 de 8 vacantes,entonces debería ver el mensaje que estoy en cola", :js => true do
		autenticarse_como_organizador
		registrar_torneo
		inscribir_y_confirmar_gamers 8
		autenticarse_como_gamer
		inscribirme_al_torneo
		confirmar_participacion
		expect(page).to have_content("Tu posición es 9 de 8 vacantes, estás en cola")
	end



	def registrar_torneo_sin_fase_confirmacion
		llenar_formulario_con_datos_correctos(30,0)
		click_button("Registrar Torneo")
		@id_torneo_registrado=find('#id_torneo_registrado').text
		click_link('link_cerrar_sesion')		
	end

	def inscribirme_al_torneo
		click_link('link_inscripcion_torneo_'+@id_torneo_registrado)
		click_button("Inscribirme")
		expect(page).to have_content("Lista de inscritos")
	end

	def confirmar_participacion
		visit "/"			
		click_link('link_confirmar_torneo_'+@id_torneo_registrado)	
	end



end
