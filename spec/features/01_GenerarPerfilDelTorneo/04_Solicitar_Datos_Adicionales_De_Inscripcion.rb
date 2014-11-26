require "spec_helper"
require "util_tests"

feature "Registrar datos de torneo" do

	scenario "Dado que registré los datos de un torneo, al continuar debería ver la pantalla de datos para inscripción ", :js => true do
		autenticarse_como_organizador		
		llenar_formulario_con_datos_correctos	    				 		
		click_button 'Siguiente'		
		expect(page).to have_content("Datos de inscripción")
	end
end
