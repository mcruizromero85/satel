 	def llenar_formulario_con_datos_correctos	
 		
 		visit("/")
		click_link("link_cabecera_registrar_torneo")

		torneo_correcto = FactoryGirl.build(:torneo)
		ronda2_correcto = FactoryGirl.build(:ronda, numero: 2)
		ronda3_correcto = FactoryGirl.build(:ronda, numero: 3)

		fill_in("torneo_titulo", :with => torneo_correcto.titulo)
	    fill_in("torneo_paginaweb", :with => torneo_correcto.paginaweb)	    
	    choose "juego_1"
	    fill_in("torneo_inicio_torneo_fecha", :with => torneo_correcto.inicio_torneo_fecha.strftime("%d/%m/%Y"))
	    fill_in("torneo_inicio_torneo_tiempo", :with => torneo_correcto.inicio_torneo_tiempo.strftime("%I:%M %p"))
		fill_in("ronda2_inicio_fecha", :with => ronda2_correcto.inicio_fecha.strftime("%d/%m/%Y"))
	    fill_in("ronda2_inicio_tiempo", :with => ronda2_correcto.inicio_tiempo.strftime("%I:%M %p"))  
	    fill_in("ronda3_inicio_fecha", :with => ronda3_correcto.inicio_fecha.strftime("%d/%m/%Y"))
	    fill_in("ronda3_inicio_tiempo", :with => ronda3_correcto.inicio_tiempo.strftime("%I:%M %p"))  
	end