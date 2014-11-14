require "spec_helper"
require "util_tests"

feature "Definir estructura del torneo" do

	scenario "Dado que la fecha de primera ronda es mayor a la de cierre de inscripción, el sistema debe alertarlo", :js => true do
		autenticarse_como_organizador
		llenar_formulario_con_datos_correctos

		cierre_inscripciones_para_manana=obtener_fecha_actual_sumando_minutos(60*24)
		inicio_ronda1_1_minuto_antes=obtener_fecha_actual_sumando_minutos((60*24)-1)
		
		fill_in("cierre_inscripcion_fecha", :with => cierre_inscripciones_para_manana.strftime("%d/%m/%Y"))
	  fill_in("cierre_inscripcion_hora", :with => cierre_inscripciones_para_manana.strftime("%I:%M %p"))

		fill_in("ronda1_inicio_fecha", :with => inicio_ronda1_1_minuto_antes.strftime("%d/%m/%Y"))		
		fill_in("ronda1_inicio_tiempo", :with => inicio_ronda1_1_minuto_antes.strftime("%I:%M %p"))

	    click_button("Registrar Torneo")
	   	expect(page).to have_content("la fecha de la primera ronda debe ser mayor a la fecha de cierre de inscripcion")
	end


	scenario "Dado que se selecciona una ronda con fecha y hora de inicio menor a la ronda anterior, entonces al publicar el torneo, él sistema debe alertarlo", :js => true do
		autenticarse_como_organizador
		llenar_formulario_con_datos_correctos

		inicio_ronda2_cuatro_dias_despues=obtener_fecha_actual_sumando_minutos(60*24*4)
		inicio_ronda3_cuatro_dias_despues_menos_1_minuto=obtener_fecha_actual_sumando_minutos((60*24*4)-1)

		fill_in("ronda2_inicio_fecha", :with => inicio_ronda2_cuatro_dias_despues.strftime("%d/%m/%Y"))
	    fill_in("ronda2_inicio_tiempo", :with => inicio_ronda2_cuatro_dias_despues.strftime("%I:%M %p"))

	    fill_in("ronda3_inicio_fecha", :with => inicio_ronda3_cuatro_dias_despues_menos_1_minuto.strftime("%d/%m/%Y"))
	    fill_in("ronda3_inicio_tiempo", :with => inicio_ronda3_cuatro_dias_despues_menos_1_minuto.strftime("%I:%M %p"))
	    click_button("Registrar Torneo")
	   	expect(page).to have_content("la fecha de inicio de la ronda 3 debe ser mayor a la ronda 2")
	end


	def obtener_fecha_actual_sumando_minutos minutos
		Time.new + (60 * minutos )
	end



end
