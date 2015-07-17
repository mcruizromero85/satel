 class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def initialize_session
    puts "Session Initialized\n"
  end
  
  def system_msg(ev, msg)
    Chat.create(user_name: 'system', received: Time.now.to_s(:short), msg_body: msg.dup) if msg.dup != '/reiniciar' && msg.dup.index('connected').to_i == 0 
    broadcast_message ev, { 
      user_name: 'system', 
      received: Time.now.to_s(:short), 
      msg_body: msg
    }    
  end
  
  def user_msg(ev, msg)
    Chat.create(user_name: connection_store[:user][:user_name], received: Time.now.to_s(:short), msg_body: msg)
    broadcast_message ev, { 
      user_name:  connection_store[:user][:user_name], 
      received:   Time.now.to_s(:short), 
      msg_body:   ERB::Util.html_escape(msg)
    }

  end
  
  def client_connected
    system_msg :new_message, "client #{client_id} connected"
  end
  
  def new_message
    user_msg :new_message, message[:msg_body].dup
  end
  
  def new_user
    connection_store[:user] = { user_name: sanitize(message[:user_name]) }
    broadcast_user_list
  end
  
  def change_username
    connection_store[:user][:user_name] = sanitize(message[:user_name])
    broadcast_user_list
  end
  
  def delete_user
    connection_store[:user] = nil
    system_msg "client #{client_id} disconnected"
    broadcast_user_list
  end
  
  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end

  def enviar_evento_encuentro
    encuentro = Encuentro.find(message[:id_encuentro])
    if encuentro.gamerinscritoa.id.to_s == message[:id_inscripcion].to_s
      encuentro.flag_listo_gamera = true
    else
      encuentro.flag_listo_gamerb = true
    end    
    if encuentro.ambos_estan_confirmados
      encuentro.iniciar_partidas
      flag_ambos_listos = true
      system_msg :new_message, '<a target="_blank" href="' + encuentro.partida_actual.field3.to_s + '"> ' + encuentro.gamerinscritoa.etiqueta_llave.to_s + ' vs ' + encuentro.gamerinscritob.etiqueta_llave.to_s + ' </a> Partida ' + encuentro.partidas.size.to_s + ' iniciada' 
    else
      flag_ambos_listos = false
    end
    encuentro.save
    timeout = encuentro.updated_at + TIME_OUT_LISTO_GAMER_EN_SEGUNDOS
    broadcast_message :actualizar_evento_encuentro, { id_inscrito_listo: message[:id_inscripcion], id_encuentro: encuentro.id, timeout_listo: timeout.to_i, flag_ambos_listos: flag_ambos_listos }
  end

  def enviar_evento_gane_partida
    partida = Partida.find(message[:id_partida_actual])
    encuentro = Encuentro.find(message[:id_encuentro])
    if encuentro.gamerinscritoa.id.to_s == message[:id_inscripcion].to_s
      partida.flag_gano_gamerinscritoa = true
    else
      partida.flag_gano_gamerinscritob = true
    end
    partida.estado = 'Debate' if partida.existe_debate
    partida.save
    timeout = partida.updated_at + TIME_OUT_LIMITE_PARA_DEBATE_DE_PARTIDA_EN_SEGUNDOS
    broadcast_message :actualizar_evento_partida_ganada, { id_inscrito_ganador: message[:id_inscripcion], id_encuentro: encuentro.id, id_partida: message[:id_partida_actual], timeout_confirmar_que_gano: timeout.to_i, flag_ambos_deacuerdo: false, partida_estado: partida.estado }
  end

  def enviar_evento_si_el_gano    
    flag_cerrar_torneo = false
    flag_encuentro_cerrado = false
    partida = Partida.find(message[:id_partida_actual])
    encuentro = Encuentro.find(message[:id_encuentro])
    id_inscripcion_ganador = message[:id_inscripcion_ganador]

    partida.estado = 'Finalizado'
    partida.save
    system_msg :new_message, 'Partida ' + encuentro.partidas.size.to_s + ' finalizada: ' + encuentro.gamerinscritoa.etiqueta_llave + '['+ encuentro.puntaje_de_inscrito(encuentro.gamerinscritoa).to_s + '] vs ' + encuentro.gamerinscritob.etiqueta_llave.to_s + '[' + encuentro.puntaje_de_inscrito(encuentro.gamerinscritob).to_s + '] </a>'
    if encuentro.tiene_partidas_pendientes
      partida_nueva = encuentro.siguiente_partida
      system_msg :new_message, '<a target="_blank" href="' + encuentro.partida_actual.field3.to_s + '"> ' + encuentro.gamerinscritoa.etiqueta_llave.to_s + ' vs ' + encuentro.gamerinscritob.etiqueta_llave.to_s + ' </a> Partida ' + encuentro.partidas.size.to_s + ' iniciada' 
    else
      encuentro.gamerinscrito_ganador = Inscripcion.new(id: id_inscripcion_ganador)
      encuentro.registrar_ganador
      if !encuentro.es_la_final
        inscripcion = Inscripcion.find(message[:id_inscripcion_ganador])
        encuentro = Encuentro.encuentro_actual_por_inscrito(inscripcion)
        system_msg :new_message, inscripcion.etiqueta_llave.to_s + ' Pasa a la siguiente ronda'
      else
        flag_cerrar_torneo = true
      end

    end
    
    broadcast_message :actualizar_evento_partida_ganada, { id_inscrito_ganador: message[:id_inscripcion], id_encuentro: encuentro.id, id_partida: partida.id, flag_ambos_deacuerdo: true, flag_cerrar_torneo: flag_cerrar_torneo }
  end
  
end
