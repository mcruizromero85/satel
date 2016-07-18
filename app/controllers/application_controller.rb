require 'net/http'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :signed_in?

  def current_gamer
    return unless !@current_gamer.nil? || !session[:gamer_id].nil?
    @current_gamer ||= Gamer.find(session[:gamer_id])
  end

  def signed_in?        
    #!current_gamer.nil?
  end

  helper_method :current_gamer, :signed_in?

  def current_gamer=(gamer)
    @current_gamer = gamer
    session[:gamer_id] = gamer.id
  end

  def revisa_si_existe_gamer_en_sesion    
    if params[:current_gamer].nil?
      respond_to do |format|
        format.json { render json: {} , status: :not_acceptable }
      end
      return
    end    
    url_facebook_api = 'https://graph.facebook.com/v2.7/me'
    uri = URI.parse(url_facebook_api)    
    params = { :access_token => current_gamer_params[:facebook_token]}
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    puts response.body
    if response.body.scan(/"error":(.*)"/)[0].nil? and response.body.scan(/"id":"(.*)"/)[0][0].to_s == current_gamer_params[:facebook_id]
      @current_gamer=Gamer.find_by(facebook_id: current_gamer_params[:facebook_id])
      if @current_gamer.nil? 
        @current_gamer = Gamer.create(current_gamer_params)
      end
      session[:gamer_id] = @current_gamer.id
    else
      respond_to do |format|
        format.json { render json: response.body , status: :not_acceptable }
      end
    end    
  end

  def current_gamer_params
    params.require(:current_gamer).permit(:id,:facebook_token, :facebook_id,:correo,:battletag)
  end

end
