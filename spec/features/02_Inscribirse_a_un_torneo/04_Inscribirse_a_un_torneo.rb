require "spec_helper"
require "util_tests"

feature "Inscribirse a un torneo" do

	scenario "Dado que existe un torneo disponible, entonces me inscribo en él", :js => true do
		autenticarse
		llenar_formulario_con_datos_correctos	    				 		
		click_button("Registrar Torneo")
		id_torneo_registrado=find('#id_torneo_registrado').text		
		expect(page).to have_content("Torneo registrado correctamente")
		click_link('link_cerrar_sesion')
		autenticarse_como_gamer
		click_link('link_inscripcion_torneo_'+id_torneo_registrado)
		click_button("Inscribirme")
		expect(page).to have_content("Lista de inscritos");
	end

	def autenticarse_como_gamer
		visit "/"
		click_link("autenticarse")
		fill_in("name", :with => "Mauro")
		fill_in("email", :with => "mcruizromero85@gmail.com")
		click_button("autenticar")
	end

end
