require "spec_helper"
require "util_tests"

feature "Confirmar Participación" do

	scenario "Dado que me inscribí a un torneo, entonces confirmo mi participación", :js => true do
		autenticarse
		registrar_torneo
		inscribirme_al_torneo
		visit "/"
	end

	def registrar_torneo
		llenar_formulario_con_datos_correctos 30
		click_button("Registrar Torneo")
		@id_torneo_registrado=find('#id_torneo_registrado').text
		expect(page).to have_content("Torneo registrado correctamente")		
	end

	def inscribirme_al_torneo
		click_link('link_cerrar_sesion')
		autenticarse_como_gamer
		click_link('link_inscripcion_torneo_'+@id_torneo_registrado)
		click_button("Inscribirme")
		expect(page).to have_content("Lista de inscritos")
	end

	def autenticarse_como_gamer
		visit "/"
		click_link("autenticarse")
		fill_in("name", :with => "Mauro")
		fill_in("email", :with => "mcruizromero85@gmail.com")
		click_button("autenticar")
	end

end
