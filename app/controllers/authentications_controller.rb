class AuthenticationsController < ApplicationController
  def edit
  end

  def create
    auth = request.env['omniauth.auth']
    
    @auth = Authentication.where('uid = ? AND provider = ?', auth['uid'], auth['provider']).first
    facebook_gamer = auth['info']
    unless @auth
      facebook_gamer = auth['info']
      gamer = Gamer.new(correo: facebook_gamer.email, apellidos: facebook_gamer.last_name)
      if params[:provider] == 'developer'
        gamer.nombres = facebook_gamer.name
        link_cuenta = "www.google.com"
      else
        gamer.nombres = facebook_gamer.first_name
        link_cuenta = auth['info'].urls.Facebook
      end
      gamer.save

      authentication = Authentication.new(provider: auth['provider'], uid: auth['uid'], gamer: gamer, link_cuenta: link_cuenta)
      authentication.save
      @auth = authentication
    end
    self.current_gamer = @auth.gamer
    redirect_to action: 'index', controller: 'torneos'
  end

  def destroy
  end

  def cerrar_sesion
    @current_gamer = nil
    session[:gamer_id] = nil
    redirect_to action: 'index', controller: 'torneos'
  end
end
