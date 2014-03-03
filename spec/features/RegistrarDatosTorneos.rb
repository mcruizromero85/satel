require "spec_helper"

feature "Registro Datos Torneo, " do

  IO.readlines("spec/features/DatosPrueba_RegistrarDatosTorneo.txt").each do |fila|
    parametros=fila.split(',')
    fecha_actual_en_segundos_segundos=Time.new.to_i
    fecha_ideal_para_registrar_torneo=Time.at(fecha_actual_en_segundos_segundos + 8000)
    fecha_registro_torneo_formateada=fecha_ideal_para_registrar_torneo.strftime('%d/%m/%Y')
  
    scenario "Dado que se ha introducido \""+parametros[0]+"\" como título del torneo y los demás datos están correctamente llenados, cuando se presiona el botón registrar, el mensaje que debe salir es \""+parametros[1]+"\"", :js => true do
      visit "/torneos/new"
      fill_in 'torneo_titulo', :with => parametros[0]
      fill_in 'torneo_paginaweb', :with => 'www.razer.com'
      fill_in 'torneo_inicio_torneo_fecha', :with => fecha_registro_torneo_formateada
      fill_in 'torneo_inicio_torneo_tiempo', :with => '06:00 PM'
      choose('torneo_vacantes2')
      click_button('Create Torneo')
      expect(page).to have_content parametros[1]
    end

  end

end
