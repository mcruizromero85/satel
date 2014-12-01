	def registrar_torneo
		llenar_formulario_con_datos_correctos 30
		click_button("Registrar Torneo")
		@id_torneo_registrado=find('#id_torneo_registrado').text				
		click_link('link_cerrar_sesion')		
	end

   	def llenar_formulario_con_datos_correctos(cantidad_minutos_a_futuro_para_cierre_inscripcion = 60,periodo_confirmacion_en_minutos=30)	

 		tiempo_actual_en_segundos=Time.new.to_i 
    	fecha_cierre_inscripcion_correcto=Time.at(tiempo_actual_en_segundos + (cantidad_minutos_a_futuro_para_cierre_inscripcion*60)) 
    	fecha_primera_ronda=fecha_cierre_inscripcion_correcto+120
    	fecha_segunda_ronda=fecha_primera_ronda+120
    	fecha_tercera_ronda=fecha_segunda_ronda+120
 		
		click_link("link_cabecera_registrar_torneo")

		torneo_correcto = FactoryGirl.build(:torneo, cierre_inscripcion: fecha_cierre_inscripcion_correcto)
		ronda1_correcto = FactoryGirl.build(:ronda, numero: 1)
		ronda2_correcto = FactoryGirl.build(:ronda, numero: 2)
		ronda3_correcto = FactoryGirl.build(:ronda, numero: 3)
		fill_in("torneo_titulo", :with => torneo_correcto.titulo)
		fill_in("torneo_paginaweb", :with => torneo_correcto.paginaweb)	    
		choose "juego_1"
		fill_in("cierre_inscripcion_fecha", :with => torneo_correcto.cierre_inscripcion.strftime("%d/%m/%Y"))
		fill_in("cierre_inscripcion_hora", :with => torneo_correcto.cierre_inscripcion.strftime("%I:%M %p"))
		if periodo_confirmacion_en_minutos== 30
			select(periodo_confirmacion_en_minutos, :from => 'torneo_periodo_confirmacion_en_minutos')
		end
		fill_in("ronda1_inicio_fecha", :with => fecha_primera_ronda.strftime("%d/%m/%Y"))
		fill_in("ronda1_inicio_tiempo", :with => fecha_primera_ronda.strftime("%I:%M %p"))
		fill_in("ronda2_inicio_fecha", :with => fecha_segunda_ronda.strftime("%d/%m/%Y"))
		fill_in("ronda2_inicio_tiempo", :with => fecha_segunda_ronda.strftime("%I:%M %p"))  
		fill_in("ronda3_inicio_fecha", :with => fecha_tercera_ronda.strftime("%d/%m/%Y"))
		fill_in("ronda3_inicio_tiempo", :with => fecha_tercera_ronda.strftime("%I:%M %p"))  
   	end

	def autenticarse_como_organizador
		visit "/"
		click_link("autenticarse")
		fill_in("name", :with => "Gissella")
		fill_in("email", :with => "gcarhuamacaquispe@gmail.com")
		click_button("autenticar")
	end

	def autenticarse_como_gamer
		visit "/"		
		click_link("autenticarse")
		fill_in("name", :with => "Mauro")
		fill_in("email", :with => "mcruizromero85@gmail.com")
		click_button("autenticar")
	end

	def inscribirse_como(nombre,correo)
		visit "/"
		click_link("autenticarse")
		fill_in("name", :with => nombre)
		fill_in("email", :with => correo)
		click_button("autenticar")
		click_link('link_inscripcion_torneo_'+@id_torneo_registrado)
		click_button("Inscribirme")
		visit "/"			
		click_link('link_confirmar_torneo_'+@id_torneo_registrado)		
		click_link('link_cerrar_sesion')
	end

	def inscribir_y_confirmar_gamers cantidad_inscritos_confirmados=8

		array_gamers_ejemplo = Array.new
		array_gamers_ejemplo << "Mauro"
		array_gamers_ejemplo << "Mateo"
		array_gamers_ejemplo << "EddyArn"
		array_gamers_ejemplo << "Brucefulus"
		array_gamers_ejemplo << "Locopiedra"
		array_gamers_ejemplo << "Sivicious"
		array_gamers_ejemplo << "Otaru"
		array_gamers_ejemplo << "Gianella"
		array_gamers_ejemplo << "Sonny"
		array_gamers_ejemplo << "Kodo"

		array_gamers_a_inscribirse=array_gamers_ejemplo.sample(cantidad_inscritos_confirmados)	

		array_gamers_a_inscribirse.each do | nombre_gamer | 
			inscribirse_como(nombre_gamer,nombre_gamer.downcase + "gmail.com")
		end					
	end
	
	def inscribirme_al_torneo
		click_link('link_inscripcion_torneo_'+@id_torneo_registrado)
		click_button("Inscribirme")
		expect(page).to have_content("Lista de inscritos")
	end

	def generar_inscripciones_confirmadas(numero_inscripciones,torneo)

		numero_inscripciones.times do
			inscripcion = FactoryGirl.create(:inscripcion, torneo: torneo)
			inscripcion.estado="Confirmado"
			inscripcion.save
		end

	end

