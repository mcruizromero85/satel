require "spec_helper"

feature "Generar estructura de encuentros" do

	(1..16).each do |i|

		scenario "Generar Inscripciones", :js => true do
	      visit "/inscripcions/new"
	      fill_in 'inscripcion_estado_confirmacion', :with => 'C'
	      fill_in 'inscripcion_peso_participacion', :with => '0'
	      valor=i.to_s
	      fill_in 'inscripcion_gamer_id', :with => valor
	      fill_in 'inscripcion_torneo_id', :with => '1'      
	      click_button('Create Inscripcion')
	      expect(page).to have_content ""
	    end
	end
 

end
