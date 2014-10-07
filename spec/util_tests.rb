   def llenar_formulario_con_datos_correctos(cantidad_horas_a_futuro_para_cierre_inscripcion = 1)	

 	tiempo_actual_en_segundos=Time.new.to_i 
    	fecha_cierre_inscripcion_correcto=Time.at(tiempo_actual_en_segundos + (cantidad_horas_a_futuro_para_cierre_inscripcion*60*60)) 
    	fecha_primera_ronda=fecha_cierre_inscripcion_correcto+120
    	fecha_segunda_ronda=fecha_primera_ronda+120
    	fecha_tercera_ronda=fecha_segunda_ronda+120
 		
 	visit("/")
	click_link("link_cabecera_registrar_torneo")

	torneo_correcto = FactoryGirl.build(:torneo, cierre_inscripcion_fecha: fecha_cierre_inscripcion_correcto,cierre_inscripcion_tiempo: fecha_cierre_inscripcion_correcto)
	ronda1_correcto = FactoryGirl.build(:ronda, numero: 1)
	ronda2_correcto = FactoryGirl.build(:ronda, numero: 2)
	ronda3_correcto = FactoryGirl.build(:ronda, numero: 3)
	fill_in("torneo_titulo", :with => torneo_correcto.titulo)
	fill_in("torneo_paginaweb", :with => torneo_correcto.paginaweb)	    
	choose "juego_1"
	fill_in("torneo_cierre_inscripcion_fecha", :with => torneo_correcto.cierre_inscripcion_fecha.strftime("%d/%m/%Y"))
	fill_in("torneo_cierre_inscripcion_tiempo", :with => torneo_correcto.cierre_inscripcion_tiempo.strftime("%I:%M %p"))
	select('10', :from => 'torneo_periodo_confirmacion_en_minutos')
	fill_in("ronda1_inicio_fecha", :with => fecha_primera_ronda.strftime("%d/%m/%Y"))
	fill_in("ronda1_inicio_tiempo", :with => fecha_primera_ronda.strftime("%I:%M %p"))
	fill_in("ronda2_inicio_fecha", :with => fecha_segunda_ronda.strftime("%d/%m/%Y"))
	fill_in("ronda2_inicio_tiempo", :with => fecha_segunda_ronda.strftime("%I:%M %p"))  
	fill_in("ronda3_inicio_fecha", :with => fecha_tercera_ronda.strftime("%d/%m/%Y"))
	fill_in("ronda3_inicio_tiempo", :with => fecha_tercera_ronda.strftime("%I:%M %p"))  
   end
