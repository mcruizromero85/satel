jQuery ->  
  objDiv = document.getElementById("chat");
  objDiv.scrollTop = objDiv.scrollHeight + 100;
  torneo_id = $('#torneo_id').val();  
  window.chatController = new Chat.Controller($('#chat').data('uri'), true);
  
window.Chat = {}


class Chat.User
  constructor: (@user_name) ->
  serialize: => { user_name: @user_name }

class Chat.Controller
  template: (message) ->
    html =
      """
      <div class="message" >
        <label class="label label-info">
          [#{message.received}] #{message.user_name}
        </label>&nbsp;
        #{message.msg_body}
      </div>
      """
    $(html)

  userListTemplate: (userList) ->
    userHtml = ""
    for user in userList    
      userHtml = userHtml + "<li>#{user.user_name}</li>" if user != null
    $(userHtml)

  constructor: (url,useWebSockets) ->
    @messageQueue = []
    @dispatcher = new WebSocketRails(url,useWebSockets)    
    @dispatcher.on_open = @createGuestUser 
    @bindEvents() 

  bindEvents: =>
    @dispatcher.bind 'new_message', @newMessage
    @dispatcher.bind 'user_list', @updateUserList
    @dispatcher.bind 'actualizar_evento_encuentro', @actualizar_evento_encuentro
    @dispatcher.bind 'actualizar_evento_partida_ganada', @actualizar_evento_partida_ganada
    $('input#user_name').on 'keyup', @updateUserInfo
    $('#send').on 'click', @sendMessage
    $('#message').keypress (e) -> $('#send').click() if e.keyCode == 13
    $('#boton_listo').on 'click', @enviar_evento_encuentro
    $('#boton_gane').on 'click', @enviar_evento_gane_partida
    $('#boton_perdi').on 'click', @enviar_evento_perdi_partida
    $('#boton_el_gano').on 'click', @enviar_evento_si_el_gano    

  enviar_evento_si_el_gano: (event) =>  
    event.preventDefault()    
    id_encuentro = $('#id_encuentro_actual').val()
    id_inscripcion = $('#id_inscripcion').val()
    id_inscripcion_contrincante = $('#id_inscripcion_contrincante').val()    
    id_partida_actual = $('#id_partida_actual').val()
    @dispatcher.trigger 'enviar_evento_si_el_gano', { id_encuentro: id_encuentro, id_inscripcion_ganador: id_inscripcion_contrincante, id_partida_actual: id_partida_actual }

  enviar_evento_gane_partida: (event) =>  
    event.preventDefault()    
    id_encuentro = $('#id_encuentro_actual').val()
    id_inscripcion = $('#id_inscripcion').val()
    id_inscripcion_contrincante = $('#id_inscripcion_contrincante').val()    
    id_partida_actual = $('#id_partida_actual').val()
    @dispatcher.trigger 'enviar_evento_gane_partida', { id_encuentro: id_encuentro, id_inscripcion: id_inscripcion, id_partida_actual: id_partida_actual }

  enviar_evento_perdi_partida: (event) =>  
    console.log('Entre a Partida Perdida')
    event.preventDefault()    
    id_encuentro = $('#id_encuentro_actual').val()
    id_inscripcion = $('#id_inscripcion').val()
    id_inscripcion_contrincante = $('#id_inscripcion_contrincante').val()    
    id_partida_actual = $('#id_partida_actual').val()
    @dispatcher.trigger 'enviar_evento_gane_partida', { id_encuentro: id_encuentro, id_inscripcion: id_inscripcion_contrincante, id_partida_actual: id_partida_actual }

  actualizar_evento_partida_ganada: (response) =>  
    id_encuentro = $('#id_encuentro_actual').val()
    id_inscripcion = $('#id_inscripcion').val()
    id_inscripcion_contrincante = $('#id_inscripcion_contrincante').val()
    id_partida_actual = $('#id_partida_actual').val()

    if response.partida_estado == 'Debate'
      location.reload();

    if parseInt(response.id_encuentro) == parseInt(id_encuentro) && $('#flag_espera_contrincante').val() == 'true' || response.flag_cerrar_torneo 
      location.reload();
      return;

    if $('#id_partida_actual').val() == (response.id_partida + '')
      if response.flag_ambos_deacuerdo == false
        if $('#id_inscripcion').val() == (response.id_inscrito_ganador + '')
          $('#boton_gane').hide()          
          $('#boton_perdi').hide()
          $('#label_gane').show()
          $('#mensaje_gane').html 'A la espera que tu contrincante confirme que ganaste, le queda: '
        else
          $('#boton_gane').html 'Crear debate, yo gane'
          $('#boton_perdi').html 'Es correcto el ganó'
          $('#boton_perdi').on 'click', @enviar_evento_si_el_gano
          $('#mensaje_gane').html '¿Tu contrincante gano esta partida?, por favor confirmalo, te queda: '
        generarContadorPorEvento('partida_ganada', new Date(response.timeout_confirmar_que_gano * 1000))
      else
        location.reload() 

  enviar_evento_encuentro: (event) =>  
    event.preventDefault()
    $('#boton_listo').html 'Procesando...'
    id_encuentro = $('#id_encuentro_actual').val()
    id_inscripcion = $('#id_inscripcion').val()
    id_inscripcion_contrincante = $('#id_inscripcion_contrincante').val()
    @dispatcher.trigger 'enviar_evento_encuentro', { id_encuentro: id_encuentro, id_inscripcion: id_inscripcion, id_inscripcion_contrincante: id_inscripcion_contrincante }

  actualizar_evento_encuentro: (response) =>  
    console.log('Entro1')
    if $('#id_encuentro_actual').val() == (response.id_encuentro + '')
      console.log('Entro2')
      if response.flag_ambos_listos == false
        console.log('Entro3')
        if $('#id_inscripcion').val() == (response.id_inscrito_listo + '')
          $('#boton_listo').hide()
          $('#label_listo').show()
          $('#mensaje_listo').html 'A la espera que tu contrincante este listo, sino es W.O a tu favor, le queda: '
        else
          $('#label_listo_contrincante').html 'Listo'
          $('#mensaje_listo').html 'Tu contrincante ya está listo, pon listo tu también sino pierdes por W.O, te queda: '
        generarContadorPorEvento('encuentro_listo', new Date(response.timeout_listo * 1000))
      else
        console.log('Entro4')
        $('#mensaje_encuentro_iniciado').val 'Encuentro iniciado'
        $('#label_listo').show()
        $('#boton_listo').hide()
        $('#mensaje_listo').html 'Encuentro iniciado!!'
        $('#countdown_encuentro_listo').hide()
        location.reload() 

  newMessage: (message) =>
    console.log('newMessage');
    @messageQueue.push message
    @shiftMessageQueue() if @messageQueue.length > 15
    @appendMessage message

  sendMessage: (event) =>
    console.log('sendMessage');
    event.preventDefault()
    message = $('#message').val()
    @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message}
    $('#message').val('')

  updateUserList: (userList) =>
    $('#user-list').html @userListTemplate(userList)

  updateUserInfo: (event) =>
    @user.user_name = $('input#user_name').val()
    $('#username').html @user.user_name
    @dispatcher.trigger 'change_username', @user.serialize()

  appendMessage: (message) ->
    if message.msg_body.toString() == '/reiniciar' && message.user_name.indexOf('(Admin)') > 0
      location.reload()
    return if message.msg_body.indexOf('connected') > 0

    messageTemplate = @template(message)
    $('#chat').append messageTemplate
    messageTemplate.slideDown 140
    objDiv = document.getElementById("chat");
    objDiv.scrollTop = objDiv.scrollHeight + 30;

  shiftMessageQueue: =>
    console.log('shiftMessageQueue');
    @messageQueue.shift()
    $('#chat div.messages:first').slideDown 100, ->
      $(this).remove()

  createGuestUser: =>
    flag_gamer_confirmado = $('#flag_gamer_confirmado').val()
    return if flag_gamer_confirmado == 'false'
    rand_num = Math.floor(Math.random()*1000)
    rand_num = document.getElementById('nombre_chat').value;
    @user = new Chat.User(rand_num)
    $('#username').html @user.user_name
    $('input#user_name').val @user.user_name
    @dispatcher.trigger 'new_user', @user.serialize()