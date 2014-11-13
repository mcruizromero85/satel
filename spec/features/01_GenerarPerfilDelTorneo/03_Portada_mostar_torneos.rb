 require "spec_helper"
 require "util_tests"

feature "Portada mostrar torneos" do
  
  scenario "Dado que no existen torneos registrados o el cierre de inscripción ya paso, entonces debe mostrarse el siguiente mensaje \"En estos momentos no existen torneos disponibles para inscribirse, organiza el tuyo!!\", <link con texto 'organizar mi torneo'>", :js => true do
    visit("/")
    expect(page).to have_content("En estos momentos no existen torneos disponibles para inscribirse, organiza el tuyo!!, organizar mi torneo")
  end

  scenario "Dado que existe más de 3 torneos registrados, todos cerraron  ayer, entonces no debe mostrarse ningún registro", :js => true do
    autenticarse_como_organizador    
    llenar_formulario_con_datos_correctos(60 * 60 * 24 * -1)
    click_button("Registrar Torneo")
    llenar_formulario_con_datos_correctos(60 * 60 * 24 * -1)
    click_button("Registrar Torneo")
    llenar_formulario_con_datos_correctos(60 * 60 * 24 * -1)
    click_button("Registrar Torneo")
    visit "/"
    expect(page).to have_content 'En estos momentos no existen torneos disponibles'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 2 días, el formato que debe mostrarse es \"2d\" ", :js => true do
    autenticarse_como_organizador
    llenar_formulario_con_datos_correctos(2 * 24  * 60)      
    click_button("Registrar Torneo")
    visit("/")
    expect(page).to have_content("2d")
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 5 días, el formato que debe mostrarse es '5d'", :js => true do
    autenticarse_como_organizador
    llenar_formulario_con_datos_correctos(5 * 24 * 60)
    click_button("Registrar Torneo")        
    visit "/"
    expect(page).to have_content '5d'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 35 horas, el formato que debe mostrarse es '1d 11h'", :js => true do
    autenticarse_como_organizador
    llenar_formulario_con_datos_correctos(35 * 60)
    click_button("Registrar Torneo")
    visit "/"
    expect(page).to have_content '1d 11h'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 66 horas, el formato que debe mostrarse es '3d'", :js => true do
    autenticarse_como_organizador
    llenar_formulario_con_datos_correctos(66 * 60)
    click_button("Registrar Torneo")        
    visit "/"
    expect(page).to have_content '3d'
  end

end
