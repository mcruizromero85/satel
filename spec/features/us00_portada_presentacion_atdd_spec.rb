require "spec_helper"

feature "US00 Portada de presentación, torneos cercanos a iniciar" do
  
  scenario "Dado que no existen torneos registrados o el cierre de inscripción ya paso, entonces debe mostrarse el siguiente mensaje 'En estos momentos no existen torneos disponibles para inscribirse, organiza el tuyo!!, <link con texto 'organizar mi torneo'>+", :js => true do
    visit "/"
      expect(page).to have_content 'En estos momentos no existen torneos disponibles para inscribirse, organiza el tuyo!!, organizar mi torneo'
  end

  scenario "Dado que existe más de 3 torneos registrados, todos cerraron  ayer, entonces no debe mostrarse ningún registro", :js => true do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24 * -1)
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24 * -1)
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24 * -1)
    visit "/"
    expect(page).to have_content 'En estos momentos no existen torneos disponibles'
  end



  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 2 días, el formato que debe mostrarse es '2d' ", :js => true do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion( 60 * 60 * 48)        
    visit "/"
    expect(page).to have_content '2d'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 5 días, el formato que debe mostrarse es '5d'", :js => true do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion( 60 * 60 * 120)        
    visit "/"
    expect(page).to have_content '5d'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 35 horas, el formato que debe mostrarse es '1d 11h'", :js => true do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion( 60 * 60 * 35)
    visit "/"
    expect(page).to have_content '1d 11h'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 59 horas, el formato que debe mostrarse es '2d'", :js => true  do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 59)        
    visit "/"
    expect(page).to have_content '2d'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 66 horas, el formato que debe mostrarse es '3d'", :js => true do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 66)        
    visit "/"
    expect(page).to have_content '3d'
  end

  scenario "Dado que existe más de 3 torneos registrados, 1 que cerro inscripciones ayer y 2 que cierran mañana, debe mostrarse solo los 2 que cierran mañana", :js => true do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24 * -1)
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24)
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24)
    visit "/"

    if find("#torneosPortada").all('tr').count == 2 then
      expect(page).to have_content ''
    elsif 
      expect(page).to have_content 'Texto artificio para forzar fail al test'
    end
  end




  def registrar_torneo_con_cierre_inscripcion_en_base_a_duracion duracion_en_segundos_hasta_cierre_inscripcion

    fecha_actual_en_segundos_segundos=Time.new.to_i
    fecha_cierre_inscripcion=Time.at(fecha_actual_en_segundos_segundos + duracion_en_segundos_hasta_cierre_inscripcion)
    
    visit "/torneos/new"
    fill_in 'torneo_titulo', :with => "testssssssssssssssssssssssssssssss" + fecha_actual_en_segundos_segundos.to_s
    fill_in 'torneo_paginaweb', :with => 'www.razer.com'
    fill_in 'torneo_inicio_torneo_fecha', :with => fecha_cierre_inscripcion.strftime('%d/%m/%Y')
    fill_in 'torneo_inicio_torneo_tiempo', :with => fecha_cierre_inscripcion.strftime('%I:%M %p')
    choose('torneo_vacantes2')
    click_button('Create Torneo')
  end

  def generarTorneos numero_torneos
    torneos_registrados=1
    while torneos_registrados <= numero_torneos
      visit "/torneos/new"
      registrar_torneo_con_cierre_inscripcion_en_base_a_duracion( 60 * 60 * 24 + torneos_registrados)        
      torneos_registrados=torneos_registrados+1
    end
  end

end
