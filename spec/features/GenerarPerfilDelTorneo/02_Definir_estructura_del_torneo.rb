require "spec_helper"
require "util_tests"

feature "Definir estructura del torneo" do

	# Como organizador de un torneo quiero definir la estructura que tendrá mi torneo inscrito, para que los Gamer participantes conozcan las fechas y el formato del torneo.

	scenario "Dado que se selecciona una fecha y hora de inicio del torneo, entonces el sistema coloca el mismo valor para la primera ronda", :js => true do
		llenar_formulario_con_datos_correctos
		fill_in("torneo_inicio_torneo_fecha", :with => obtener_fecha_actual_sumando_minutos(120).strftime("%d/%m/%Y"))
	    fill_in("torneo_inicio_torneo_tiempo", :with => obtener_fecha_actual_sumando_minutos(120).strftime("%I:%M %p"))
	    expect(find('#ronda1_inicio_fecha').value).to have_content(find('#torneo_inicio_torneo_fecha').value)
	    expect(find('#ronda1_inicio_tiempo').value).to have_content(find('#torneo_inicio_torneo_tiempo').value)
	end

	scenario "Dado que se selecciona una fecha y hora de inicio del torneo, entonces el sistema calcula la fecha de cierre de inscripcion, restándole 45 minutos", :js => true do

		llenar_formulario_con_datos_correctos
		inicio_torneo_tres_horas_despues=obtener_fecha_actual_sumando_minutos(60 * 3)
		cierre_cuarentaycinco_minutos_antes=inicio_torneo_tres_horas_despues - ( 60 * 45)
		fill_in("torneo_inicio_torneo_fecha", :with => inicio_torneo_tres_horas_despues.strftime("%d/%m/%Y"))
	    fill_in("torneo_inicio_torneo_tiempo", :with => inicio_torneo_tres_horas_despues.strftime("%I:%M %p"))

	    expect(find('#torneo_cierre_inscripcion_fecha').value).to have_content(cierre_cuarentaycinco_minutos_antes.strftime("%d/%m/%Y"))
	    expect(find('#torneo_cierre_inscripcion_tiempo').value).to have_content(cierre_cuarentaycinco_minutos_antes.strftime("%I:%M %p"))
	end

	scenario "Dado que se selecciona una ronda con fecha y hora de inicio menor a una hora después de la ronda anterior, entonces al publicar el torneo, él mensaje que debe salir es \“Las rondas deben tener más de 1 hora de diferencia entre ellas\"", :js => true do

		llenar_formulario_con_datos_correctos

		inicio_ronda2_cuatro_dias_despues=obtener_fecha_actual_sumando_minutos(60*24*4)
		inicio_ronda3_cuatro_dias_despues_mas_30_minutos=obtener_fecha_actual_sumando_minutos((60*24*4)+30)

		fill_in("ronda2_inicio_fecha", :with => inicio_ronda2_cuatro_dias_despues.strftime("%d/%m/%Y"))
	    fill_in("ronda2_inicio_tiempo", :with => inicio_ronda2_cuatro_dias_despues.strftime("%d/%m/%Y"))

	    fill_in("ronda3_inicio_fecha", :with => inicio_ronda3_cuatro_dias_despues_mas_30_minutos.strftime("%d/%m/%Y"))
	    fill_in("ronda3_inicio_tiempo", :with => inicio_ronda3_cuatro_dias_despues_mas_30_minutos.strftime("%d/%m/%Y"))
	    click_button("Registrar Torneo")
	   	expect(page).to have_content("Las rondas deben tener más de 1 hora de diferencia entre ellas")
	end

	def obtener_fecha_actual_sumando_minutos minutos
		Time.new + (60 * minutos )
	end



end
