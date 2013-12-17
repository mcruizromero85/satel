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
    visit "/"
    registrarTorneoConFechaCierreInscripcionEnSegundos( 60 * 60 * 48)

  end

  def registrarTorneoConFechaInscripcion fecha_cierre_inscripcion_en_segundos
    visit "/torneos/new"
    fill_in "torneo[nombre]", :with => "Torneo xyz " + fecha_cierre_inscripcion_en_segundos.to_s
    fill_in "torneo[juego]", :with => "Dota 2"
    fill_in "torneo[vacantes]", :with => "15"

    select('2014', :from => 'torneo_cierre_inscripcion_1i')
    select('16', :from => 'torneo_cierre_inscripcion_3i')

  end

  def generarTorneos numero_torneos
    torneos_registrados=1
    while torneos_registrados <= numero_torneos
      visit "/torneos/new"

      fill_in "torneo[nombre]", :with => "Torneo xyz " + torneos_registrados.to_s
      fill_in "torneo[juego]", :with => "Dota 2"
      fill_in "torneo[vacantes]", :with => "15"

      select('2014', :from => 'torneo_cierre_inscripcion_1i')
      select('16', :from => 'torneo_cierre_inscripcion_3i')

      click_on "Create Torneo"

      expect(page).to have_text("Torneo was successfully created")
      torneos_registrados=torneos_registrados+1
    end
  end

end