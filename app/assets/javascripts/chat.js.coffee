jQuery ->  
  torneo_id = $('#torneo_id').val();  
  window.chatController = new Chat.Controller($('#chat').data('uri' + torneo_id), true);
  
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
    $('input#user_name').on 'keyup', @updateUserInfo
    $('#send').on 'click', @sendMessage
    $('#message').keypress (e) -> $('#send').click() if e.keyCode == 13
    $('#boton_listo').on 'click', @enviar_evento_encuentro

  enviar_evento_encuentro: (event) =>  
    event.preventDefault()    
    id_encuentro = $('#id_encuentro_actual').val()
    id_inscripcion = $('#id_inscripcion').val()
    id_inscripcion_contrincante = $('#id_inscripcion_contrincante').val()
    console.log('id_encuentro ' + id_encuentro );
    console.log('id_inscripcion ' + id_inscripcion );
    console.log('id_inscripcion_contrincante ' + id_inscripcion_contrincante );
    @dispatcher.trigger 'enviar_evento_encuentro', { id_encuentro: id_encuentro, id_inscripcion: id_inscripcion, id_inscripcion_contrincante: id_inscripcion_contrincante }

  actualizar_evento_encuentro: (response) =>  
    console.log('id_inscrito_listo ' + response.id_inscrito_listo );
    console.log('id_encuentro ' + response.id_encuentro );
    if $('#id_encuentro_actual').val == response.id_encuentro
      if $('#id_inscripcion').val == response.id_inscrito_listo
        $('#boton_listo').hide()
        $('#label_listo').show()
      else
         $('#label_listo_contrincante').html 'Listo'

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
    console.log('appendMessage');
    messageTemplate = @template(message)
    $('#chat').append messageTemplate
    messageTemplate.slideDown 140

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