require "spec_helper"

feature "Generar estructura de encuentros" do

    scenario "Generar Inscripciones", :js => true do
      visit "/inscripcions/new"
      fill_in 'inscripcion_estado_confirmacion', :with => 'C'
      fill_in 'inscripcion_peso_participacion', :with => '0'
      fill_in 'inscripcion_gamer_id', :with => 1
      fill_in 'inscripcion_torneo_id', :with => '15'      
      click_button('Create Inscripcion')
      expect(page).to have_content ""
    end

 

end
