require "spec_helper"
require "util_tests"

feature "Registrar datos de torneo" do

	#Como organizador quiero registrar los datos de mi torneo, para poder promocionarlo.

	scenario "Dado que se ha introducido correctamente todos los datos, cuando se publica el torneo debe salir un mensaje exitoso", :js => true do

		llenar_formulario_con_datos_correctos	    				 		
		click_button("Registrar Torneo")		
		expect(page).to have_content("Torneo registrado correctamente")
	end

	scenario "Dado que se ha introducido un título menor a 30 o mayor a 100 caracteres como título del torneo y los demás datos están correctamente llenados, cuando se publica el torneo, el sistema debe advertirlo", :js => true do		
		listado_titulo_torneos_errados.each  do |titulo_torneo_errado|

		    llenar_formulario_con_datos_correctos	    
		    fill_in("torneo_titulo", :with => titulo_torneo_errado)
			click_button("Registrar Torneo")
		    expect(page).to have_content("el título debe estar entre 30 y 100 caracteres")
		end    
	end

	scenario "Dado que se ha introducido una página web errada y los demás datos están correctamente llenados, cuando se publica el torneo, el sistema debe advertirlo", :js => true do

		llenar_formulario_con_datos_correctos	    		
		fill_in("torneo_paginaweb", :with => "pagina errada")
		click_button("Registrar Torneo")
		expect(page).to have_content("la página web debe tener el formato de una url, incluido http:// o https://")
	end

	scenario "Dado que se ha introducido como fecha de cierre de inscripcion del torneo una fecha menor a la actual y los demás datos están correctamente llenados, el sistema debe advertirlo",:js => true do
		listado_fecha_hora_torneo_errados.each  do |fecha_hora_torneo_errado|

			llenar_formulario_con_datos_correctos	    		
			fill_in("torneo_cierre_inscripcion_fecha", :with => fecha_hora_torneo_errado.strftime("%d/%m/%Y") )
			fill_in("torneo_cierre_inscripcion_tiempo", :with => fecha_hora_torneo_errado.strftime("%I:%M %p"))
			click_button("Registrar Torneo")
			expect(page).to have_content("la fecha de cierre de inscripciones tiene que ser mayor a la actual")
		end
	end

	scenario "Dado que se ha introducido como fecha de cierre de inscripcion formatos invalidos, el sistema debe advertirlo",:js => true do
		listado_fecha_hora_torneo_errados.each  do |fecha_hora_torneo_errado|

			llenar_formulario_con_datos_correctos	    		
			fill_in("torneo_cierre_inscripcion_fecha", :with => "adasdadas" )
			fill_in("torneo_cierre_inscripcion_tiempo", :with => "ggggg" )
			click_button("Registrar Torneo")
			expect(page).to have_content("la fecha debe estar en formato dd/mm/yyyy")
			expect(page).to have_content("la hora debe estar en formato hh:mm AM/PM")
		end
	end
	
	def listado_titulo_torneos_errados
		["Torneo xyz","Torneo mayor a 100 caracteres,1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950"]
	end

	def listado_fecha_hora_torneo_errados
		[Time.new-60]
	end



end
