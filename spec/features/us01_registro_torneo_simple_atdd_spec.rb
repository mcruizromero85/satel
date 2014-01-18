require "spec_helper"

feature "US01 Registro Torneo simple" do

  scenario "Dado que la fecha de inicio del torneo es mayor a la actual, por menos de una hora, entonces el sistema debe advertirlo", :js => true do
    visit "/torneos/new"
    fill_in 'torneo_titulo', :with => 'Torneo Razer'
    fill_in 'torneo_paginaweb', :with => 'www.razer.com'
    fill_in 'torneo_inicio_torneo_fecha', :with => '03/01/2014'
    fill_in 'torneo_inicio_torneo_tiempo', :with => '06:00 PM'
    choose('torneo_vacantes2')
    expect(page).to have_content 'El inicio del torneo debe ser mayor a 1 hora desde la fecha actual'
  end

  scenario "Dado que la fecha de inicio del torneo es menor a la actual, entonces el sistema debe advertirlo", :js => true do
    visit "/torneos/new"
    fill_in 'torneo_titulo', :with => 'Torneo Razer'
    fill_in 'torneo_paginaweb', :with => 'www.razer.com'
    fill_in 'torneo_inicio_torneo_fecha', :with => '01/01/2014'
    fill_in 'torneo_inicio_torneo_tiempo', :with => '07:40 AM'
    choose('torneo_vacantes4')
    expect(page).to have_content 'El inicio del torneo es menor a la fecha actual'
  end

end