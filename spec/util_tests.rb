  def registrar_torneo
    registrar(30, 30)
    click_button('Siguiente')
    click_button('Registrar torneo')    
    @id_torneo_registrado = find('#id_torneo_registrado').text
    click_link('link_cerrar_sesion')
  end

  def registrar(minutos_cierre_inscripcion = 60, minutos_confirmacion = 0)
    cierre_inscripcion = Time.new + (minutos_cierre_inscripcion * 60)
    primera_ronda = cierre_inscripcion + 120
    segunda_ronda = primera_ronda + 120
    tercera_ronda = segunda_ronda + 120
    click_link('link_cabecera_registrar_torneo')
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: cierre_inscripcion)

    fill_in('torneo_titulo', with: torneo.titulo)
    fill_in('torneo_paginaweb', with: torneo.paginaweb)
    choose 'juego_1'
    fill_in('cierre_inscripcion_fecha', with: cierre_inscripcion.strftime('%d/%m/%Y'))
    fill_in('cierre_inscripcion_hora', with: cierre_inscripcion.strftime('%I:%M %p'))
    if minutos_confirmacion > 0
      select(minutos_confirmacion, from: 'torneo_periodo_confirmacion_en_minutos')
    end
    fill_in('ronda1_inicio_fecha', with: primera_ronda.strftime('%d/%m/%Y'))
    fill_in('ronda1_inicio_tiempo', with: primera_ronda.strftime('%I:%M %p'))
    fill_in('ronda2_inicio_fecha', with: segunda_ronda.strftime('%d/%m/%Y'))
    fill_in('ronda2_inicio_tiempo', with: segunda_ronda.strftime('%I:%M %p'))
    fill_in('ronda3_inicio_fecha', with: tercera_ronda.strftime('%d/%m/%Y'))
    fill_in('ronda3_inicio_tiempo', with: tercera_ronda.strftime('%I:%M %p'))
  end

  def autenticarse_como_organizador
    visit '/'
    click_link('autenticarse')
    fill_in('name', with: 'Gissella')
    fill_in('email', with: 'gcarhuamacaquispe@gmail.com')
    click_button('autenticar')
  end

  def autenticarse_como_gamer
    visit '/'
    click_link('autenticarse')
    fill_in('name', with: 'Mauro')
    fill_in('email', with: 'mcruizromero85@gmail.com')
    click_button('autenticar')
  end

  def inscribirse_como(nombre, correo)
    visit '/'
    click_link('autenticarse')
    fill_in('name', with: nombre)
    fill_in('email', with: correo)
    click_button('autenticar')
    click_link('link_inscripcion_torneo_' + @id_torneo_registrado)
    fill_in('gamer_nick', with: nombre)    
    click_button('Inscribirme')
    visit '/'
    click_link('link_confirmar_torneo_' + @id_torneo_registrado)
    click_link('link_cerrar_sesion')
  end

  def confirmar_gamers(confirmados = 8)
    array_gamers_ejemplo = []
    array_gamers_ejemplo << 'Mauro'
    array_gamers_ejemplo << 'Mateo'
    array_gamers_ejemplo << 'EddyArn'
    array_gamers_ejemplo << 'Brucefulus'
    array_gamers_ejemplo << 'Locopiedra'
    array_gamers_ejemplo << 'Sivicious'
    array_gamers_ejemplo << 'Otaru'
    array_gamers_ejemplo << 'Gianella'
    array_gamers_ejemplo << 'Sonny'
    array_gamers_ejemplo << 'Kodo'
    array_gamers_a_inscribirse = array_gamers_ejemplo.sample(confirmados)
    array_gamers_a_inscribirse.each do | nombre_gamer |
      inscribirse_como(nombre_gamer, nombre_gamer.downcase + 'gmail.com')
    end
  end

  def inscribirme_al_torneo
    click_link('link_inscripcion_torneo_' + @id_torneo_registrado)
    click_button('Inscribirme')
    expect(page).to have_content('Lista de inscritos')
  end

  def generar_inscripciones_confirmadas(numero_inscripciones, torneo)
    numero_inscripciones.times do
      inscripcion = FactoryGirl.create(:inscripcion, torneo: torneo)
      inscripcion.estado = 'Confirmado'
      inscripcion.save
    end
  end

  def reportar_resultado_encuentro_por_ronda_llave(torneo, posicion_ronda, posicion_encuentro_en_ronda,flag_ganador = "A")    
    encuentro_para_reportar_ganador = torneo.rondas[posicion_ronda - 1].encuentros[posicion_encuentro_en_ronda - 1]
    if flag_ganador == "A"
      encuentro_para_reportar_ganador.gamerinscrito_ganador = encuentro_para_reportar_ganador.gamerinscritoa
    else
      encuentro_para_reportar_ganador.gamerinscrito_ganador = encuentro_para_reportar_ganador.gamerinscritob
    end
    encuentro_para_reportar_ganador.registrar_ganador
  end

  def torneo_iniciado_con_vacantes_confirmadas(vacantes_confirmadas = 8)
    torneo = FactoryGirl.build(:torneo, cierre_inscripcion: Time.new + 10, vacantes: vacantes_confirmadas)
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 1))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 2))
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 3)) if vacantes_confirmadas > 4 
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 4)) if vacantes_confirmadas > 8
    torneo.agregar_ronda(FactoryGirl.build(:ronda, numero: 5)) if vacantes_confirmadas > 16    
    torneo.save
    generar_inscripciones_confirmadas(vacantes_confirmadas, torneo)
    torneo.generar_encuentros
    torneo.estado = 'Iniciado'
    torneo.save
    return torneo
  end
