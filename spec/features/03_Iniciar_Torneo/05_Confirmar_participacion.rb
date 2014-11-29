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

	def confirmar_participacion
		visit "/"			
		click_link('link_confirmar_torneo_'+@id_torneo_registrado)	
	end



end
