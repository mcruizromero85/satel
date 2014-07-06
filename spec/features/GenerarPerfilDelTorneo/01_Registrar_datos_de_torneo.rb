require "spec_helper"
require "util_tests"

feature "Registrar datos de torneo" do

	#Como organizador quiero registrar los datos de mi torneo, para poder promocionarlo.

	scenario "Dado que se ha introducido correctamente todos los datos, cuando se publica el torneo, el mensaje que debe salir es \"Torneo registrado correctamente\"", :js => true do

		llenar_formulario_con_datos_correctos	    				 		
		click_button("Registrar Torneo")		
		expect(page).to have_content("Torneo registrado correctamente")
	end

	scenario "Dado que se ha introducido un título menor a 30 o mayor a 100 caracteres como título del torneo y los demás datos están correctamente llenados, cuando se publica el torneo, el mensaje que debe salir es \"El título debe estar entre 30 y 100 caracteres\"", :js => true do		
		listado_titulo_torneos_errados.each  do |titulo_torneo_errado|

		    llenar_formulario_con_datos_correctos	    
		    fill_in("torneo_titulo", :with => titulo_torneo_errado)
			click_button("Registrar Torneo")
		    expect(page).to have_content("El título debe estar entre 30 y 100 caracteres")
		end    
	end

	scenario "Dado que se ha introducido una página web errada y los demás datos están correctamente llenados, cuando se publica el torneo, el mensaje que debe salir es \"La página web debe tener el formato de una url\"", :js => true do

		llenar_formulario_con_datos_correctos	    		
		fill_in("torneo_paginaweb", :with => "pagina errada")
		click_button("Registrar Torneo")
		expect(page).to have_content("La página web debe tener el formato de una url")
	end

	scenario "Dado que se ha introducido como fecha de inicio del torneo una fecha menor a la actual o mayor por menos de 1 hora, y los demás datos están correctamente llenados, el mensaje que debe salir es \"La fecha de inicio tiene que ser mayor a la actual por más de 1 hora\"",:js => true do
		listado_fecha_hora_torneo_errados.each  do |fecha_hora_torneo_errado|

			llenar_formulario_con_datos_correctos	    		
			fill_in("torneo_inicio_torneo_fecha", :with => fecha_hora_torneo_errado.strftime("%d/%m/%Y") )
			fill_in("torneo_inicio_torneo_tiempo", :with => fecha_hora_torneo_errado.strftime("%I:%M %p"))
			click_button("Registrar Torneo")
			expect(page).to have_content("La fecha de inicio tiene que ser mayor a la actual por más de 1 hora")
		end
	end
	
	def listado_titulo_torneos_errados
		["Torneo xyz","Torneo mayor a 100 caracteres,1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950"]
	end

	def listado_fecha_hora_torneo_errados
		[Time.new]
	end



end
