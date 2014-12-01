class AuthenticationsController < ApplicationController
 

  # GET /authentications/1/edit
  def edit
  end

  # POST /authentications
  # POST /authentications.json
  def create

    auth = request.env["omniauth.auth"]
    

    unless @auth = Authentication.where("uid = ? AND provider = ?", auth['uid'],auth['provider']).first
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      facebook_gamer = auth['info']
      gamer = Gamer.new
      gamer.correo = facebook_gamer.email
      if params[:provider] == "developer"
        gamer.nombres = facebook_gamer.name
      else
        gamer.nombres = facebook_gamer.first_name
      end
      gamer.apellidos = facebook_gamer.last_name
      gamer.save

      authentication = Authentication.new
      authentication.provider =  auth['provider']
      authentication.uid = auth['uid']
      authentication.gamer = gamer
      authentication.save
      @auth = authentication
    end
    # Log the authorizing user in.
    self.current_gamer = @auth.gamer

    if session[:last_url_pre_login] != nil
      redirect_to session[:last_url_pre_login]
    else
      redirect_to :action => 'index', :controller=>"torneos"    
    end

    
  end

  def destroy
  end

  def cerrar_sesion    
    @current_gamer = nil
    session[:gamer_id] = nil
    redirect_to :action => 'index', :controller=>"torneos"  
  end


end
