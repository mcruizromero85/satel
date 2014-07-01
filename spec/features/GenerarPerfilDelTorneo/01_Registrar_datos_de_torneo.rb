require "spec_helper"

feature "Registrar datos de torneo" do

	#o	Dado que los datos están correctamente llenados, cuando se publica el torneo, el mensaje que debe salir es "Torneo registrado correctamente".
	#o	Dado que se ha introducido un título menor a 30 o mayor a 100 caracteres  como título del torneo y los demás datos están correctamente llenados, cuando se publica el torneo, el mensaje que debe salir es "El título debe estar entre 30 y 100 caracteres".	
	#o	Dado que se ha introducido una página web errada y los demás datos están correctamente llenados, cuando se publica el torneo, el mensaje que debe salir es "La página web debe tener el formato de una url”.
	#o	Dado que se ha introducido como fecha de inicio del torneo una fecha menor a la actual o mayor por menos de 1 hora, y los demás datos están correctamente llenados, el mensaje que debe salir es “La fecha de inicio tiene que ser mayor a la actual por más de 1 hora”.


	# PRUEBAS MANUALES
	# ================
	# Dado que se ha seleccionado un número menor a 4 o mayor 32 como número de vacantes del torneo y los demás datos están correctamente llenados, cuando se presiona el botón registrar, el mensaje que debe salir es "Las vacantes deben estar entre los valores 4 y 32"(Manual).

	#Datos Correctos para un registro
	TORNEO_TITULO_CORRECTO="TORNEO DE CS 1.6 ONLINE - THE LAST CHANCE"	 
	TORNEO_PAGINAWEB_CORRECTO="http://www.bloodzone.net/forums/f25/torneo-de-cs-1-6-online-last-chance-108544/" 
	TORNEO_INICIO_TORNEO_FECHA_CORRECTO="29/06/2014" 
	TORNEO_INICIO_TORNEO_TIEMPO_CORRECTO="01:38 AM" 
	RONDA2_INICIO_FECHA_CORRECTO="29/06/2014" 
	RONDA2_INICIO_TIEMPO_CORRECTO="03:38 AM" 
	RONDA3_INICIO_FECHA_CORRECTO="29/06/2014" 
	RONDA3_INICIO_TIEMPO_CORRECTO="05:38 AM"

	scenario "Dado que se ha introducido correctamente todos los datos, cuando se publica el torneo, el mensaje que debe salir es \"Torneo registrado correctamente\"", :js => true do
		visit "/"
		click_link "link_cabecera_registrar_torneo"
		llenar_formulario_con_datos_correctos	    				 
		click_button("Registrar Torneo")
		expect(page).to have_content("Torneo registrado correctamente")
	end

	scenario "Dado que se ha introducido un título menor a 30 o mayor a 100 caracteres como título del torneo y los demás datos están correctamente llenados, cuando se publica el torneo, el mensaje que debe salir es \"El título debe estar entre 30 y 100 caracteres\"", :js => true do		
		listado_titulo_torneos_errados.each  do |titulo_torneo_errado|
		    visit "/"
		    click_link "link_cabecera_registrar_torneo"
		    llenar_formulario_con_datos_correctos	    
		    fill_in("torneo_titulo", :with => titulo_torneo_errado)
			click_button("Registrar Torneo")
		    expect(page).to have_content("El título debe estar entre 30 y 100 caracteres")
		end    
	end

	scenario "Dado que se ha introducido una página web errada y los demás datos están correctamente llenados, cuando se publica el torneo, el mensaje que debe salir es \"La página web debe tener el formato de una url\"", :js => true do
		visit "/"
		click_link "link_cabecera_registrar_torneo"
		llenar_formulario_con_datos_correctos	    		
		fill_in("torneo_paginaweb", :with => "pagina errada")
		click_button("Registrar Torneo")
		expect(page).to have_content("La página web debe tener el formato de una url")
	end

	scenario "Dado que se ha introducido como fecha de inicio del torneo una fecha menor a la actual o mayor por menos de 1 hora, y los demás datos están correctamente llenados, el mensaje que debe salir es \"La fecha de inicio tiene que ser mayor a la actual por más de 1 hora\"",:js => true do
		listado_fecha_hora_torneo_errados.each  do |fecha_hora_torneo_errado|
			visit "/"
			click_link "link_cabecera_registrar_torneo"
			llenar_formulario_con_datos_correctos	    		
			fill_in("torneo_inicio_torneo_fecha", :with => fecha_hora_torneo_errado.strftime("%d/%m/%Y") )
			fill_in("torneo_inicio_torneo_tiempo", :with => fecha_hora_torneo_errado.strftime("%I:%M %p"))
			page.save_screenshot('screenshot.png')
			click_button("Registrar Torneo")
			expect(page).to have_content("La fecha de inicio tiene que ser mayor a la actual por más de 1 hora")
		end
	end

	def llenar_formulario_con_datos_correctos		
		fill_in("torneo_titulo", :with => TORNEO_TITULO_CORRECTO)
	    fill_in("torneo_paginaweb", :with => TORNEO_PAGINAWEB_CORRECTO)	    
	    choose "juego_1"
	    fill_in("torneo_inicio_torneo_fecha", :with => TORNEO_INICIO_TORNEO_FECHA_CORRECTO)
	    fill_in("torneo_inicio_torneo_tiempo", :with => TORNEO_INICIO_TORNEO_TIEMPO_CORRECTO)
		fill_in("ronda2_inicio_fecha", :with => RONDA2_INICIO_FECHA_CORRECTO)
	    fill_in("ronda2_inicio_tiempo", :with => RONDA2_INICIO_TIEMPO_CORRECTO)
		fill_in("ronda3_inicio_fecha", :with => RONDA3_INICIO_FECHA_CORRECTO)
	    fill_in("ronda3_inicio_tiempo", :with => RONDA3_INICIO_TIEMPO_CORRECTO)	    
	end
	
	def listado_titulo_torneos_errados
		["Torneo xyz","Torneo mayor a 100 caracteres,1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950"]
	end

	def listado_fecha_hora_torneo_errados
		[Time.new]
	end



end
