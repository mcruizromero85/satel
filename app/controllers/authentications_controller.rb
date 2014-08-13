class AuthenticationsController < ApplicationController
  before_action :set_authentication, only: [:show, :edit, :update, :destroy]

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
      gamer.nombres = facebook_gamer.first_name
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authentication
      @authentication = Authentication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authentication_params
      params.require(:authentication).permit(:user_id, :provider, :uid, :index, :create, :destroy)
    end
end
