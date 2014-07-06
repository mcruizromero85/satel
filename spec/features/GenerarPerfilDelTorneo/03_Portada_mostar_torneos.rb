 require "spec_helper"
 require "util_tests"

feature "Portada mostrar torneos" do
  
  scenario "Dado que no existen torneos registrados o el cierre de inscripción ya paso, entonces debe mostrarse el siguiente mensaje \"En estos momentos no existen torneos disponibles para inscribirse, organiza el tuyo!!\", <link con texto 'organizar mi torneo'>", :js => true do
    visit("/")
    expect(page).to have_content("En estos momentos no existen torneos disponibles para inscribirse, organiza el tuyo!!, organizar mi torneo")
  end


  scenario "Dado que existe un torneo con fecha de cierre de inscripción a 2 días, el formato que debe mostrarse es \"2d\" ", :js => true do
    registrar_torneo_con_cierre_inscripcion_mayor_a_la_fecha_actual_en_horas(48)            
    visit("/")
    expect(page).to have_content("2d")
  end


  def registrar_torneo_con_cierre_inscripcion_mayor_a_la_fecha_actual_en_horas(duracion_en_horas_hasta_cierre_inscripcion)
    visit("/")
    click_link("link_cabecera_registrar_torneo")
    llenar_formulario_con_datos_correctos
    tiempo_actual_en_segundos=Time.new.to_i 
    fecha_cierre_inscripcion=Time.at(tiempo_actual_en_segundos + (duracion_en_horas_hasta_cierre_inscripcion*60*60))
    fill_in("torneo_inicio_torneo_fecha", :with => fecha_cierre_inscripcion.strftime("%d/%m/%Y"))
    fill_in("torneo_inicio_torneo_tiempo", :with => fecha_cierre_inscripcion.strftime("%I:%M %p"))
    click_button("Registrar Torneo")
  end

end
