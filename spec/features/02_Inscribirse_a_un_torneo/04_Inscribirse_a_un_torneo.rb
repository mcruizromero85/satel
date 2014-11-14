require "spec_helper"
require "util_tests"

feature "Inscribirse a un torneo" do

	scenario "Dado que me inscribí a un torneo, entonces debo ver un mensaje de validación", :js => true do
		autenticarse_como_organizador
		registrar_torneo
		autenticarse_como_gamer
		inscribirme_al_torneo
		expect(page).to have_content("Tu Inscripción se realizó con exito")
	end


end
