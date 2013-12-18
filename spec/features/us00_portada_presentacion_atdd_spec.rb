require "spec_helper"

feature "US00 Portada de presentación, torneos cercanos a iniciar" do

  scenario "Dado que existen 26 torneos, al ingresar a la portada solo deben verse 20" do
    generarTorneos 26
    visit "/"
    
    if find("#torneosPortada").all('tr').count == 20 then
      expect(page).to have_content ''
    elsif 
      expect(page).to have_content 'Texto artificio para forzar fail al test'
    end
  end

  scenario "Dado que existen 18 torneos, al ingresar a la portada solo deben verse 18" do
    generarTorneos 18
    visit "/"

    if find("#torneosPortada").all('tr').count == 18 then
      expect(page).to have_content ''
    elsif 
      expect(page).to have_content 'Texto artificio para forzar fail al test'
    end
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 2 días, el formato que debe mostrarse es '2d' " do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion( 60 * 60 * 48)        
    visit "/"
    expect(page).to have_content '2d'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 5 días, el formato que debe mostrarse es '5d'" do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion( 60 * 60 * 120)        
    visit "/"
    expect(page).to have_content '5d'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 35 horas, el formato que debe mostrarse es '1d 11h'" do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion( 60 * 60 * 35)
    visit "/"
    expect(page).to have_content '1d 11h'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 12335 segundos, el formato que debe mostrarse es '3h 25m 35s'" do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(12335)        
    visit "/"
    expect(page).to have_content '3h 25m' # se retira segundos para considerar el delay que demora ir entre el registro y el homepage
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 59 horas, el formato que debe mostrarse es '2d'" do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 59)        
    visit "/"
    expect(page).to have_content '2d'
  end

  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 66 horas, el formato que debe mostrarse es '3d'" do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 66)        
    visit "/"
    expect(page).to have_content '3d'
  end

  scenario "Dado que existe más de 3 torneos registrados, 1 que cerro inscripciones ayer y 2 que cierran mañana, debe mostrarse solo los 2 que cierran mañana" do
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

  scenario "Dado que existe más de 3 torneos registrados, todos cerraron  ayer, entonces no debe mostrarse ningún registro" do
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24 * -1)
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24 * -1)
    registrar_torneo_con_cierre_inscripcion_en_base_a_duracion(60 * 60 * 24 * -1)
    visit "/"

    if find("#torneosPortada").all('tr').count == 0 then
      expect(page).to have_content ''
    elsif 
      expect(page).to have_content 'Texto artificio para forzar fail al test'
    end
  end


  def registrar_torneo_con_cierre_inscripcion_en_base_a_duracion duracion_en_segundos_hasta_cierre_inscripcion
    visit "/torneos/new"
    fill_in "torneo[nombre]", :with => "Torneo xyz " + duracion_en_segundos_hasta_cierre_inscripcion.to_s
    fill_in "torneo[juego]", :with => "Dota 2"
    fill_in "torneo[vacantes]", :with => "15"

    fecha_actual_en_segundos_segundos=Time.new.to_i
    fecha_cierre_inscripcion=Time.at(fecha_actual_en_segundos_segundos + duracion_en_segundos_hasta_cierre_inscripcion)
      
    select(fecha_cierre_inscripcion.year, :from => 'torneo_cierre_inscripcion_fecha_1i')    
    within '#torneo_cierre_inscripcion_fecha_2i' do
      find("option[value='" + fecha_cierre_inscripcion.month.to_s + "']").click
    end
    
    select(fecha_cierre_inscripcion.day, :from => 'torneo_cierre_inscripcion_fecha_3i')
    select(fecha_cierre_inscripcion.strftime('%H'), :from => 'torneo_cierre_inscripcion_tiempo_4i')
    select(fecha_cierre_inscripcion.strftime('%M'), :from => 'torneo_cierre_inscripcion_tiempo_5i')
    click_on "Create Torneo"
    
    expect(page).to have_text("Torneo was successfully created")
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