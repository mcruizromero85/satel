require 'spec_helper'
require 'util_tests'

feature 'Registrar datos de torneo' do

  scenario 'Dado que el usuario no se encuentra logueado y seleccionar organizar torneo, entonces debe redireccionar al login de facebook', js: true do
    visit '/'
    click_link('link_cabecera_registrar_torneo')
    expect(page).to have_content('User Info')
  end

  scenario 'Dado que se ha introducido correctamente todos los datos, cuando se publica el torneo debe salir un mensaje exitoso', js: true do
    autenticarse_como_organizador
    registrar
    click_button('Siguiente')
    click_button('Registrar torneo')
    expect(page).to have_content('Torneo registrado correctamente')
  end

  scenario 'Dado que se ha introducido como fecha de cierre de inscripcion formatos invalidos, el sistema debe advertirlo', js: true do
    autenticarse_como_organizador
    registrar
    fill_in('cierre_inscripcion_fecha', with: 'adasdadas')
    fill_in('cierre_inscripcion_hora', with: 'ggggg')
    click_button('Siguiente')
    expect(page).to have_content('la fecha de cierre de inscripciones tiene que ser mayor a la actual')
  end
end
