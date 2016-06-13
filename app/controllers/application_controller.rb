class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :signed_in?

  def current_gamer
    return unless !@current_gamer.nil? || !session[:gamer_id].nil?
    @current_gamer ||= Gamer.find(session[:gamer_id])
  end

  def signed_in?
    !current_gamer.nil?
  end

  helper_method :current_gamer, :signed_in?

  def current_gamer=(gamer)
    @current_gamer = gamer
    session[:gamer_id] = gamer.id
  end

  def revisa_si_existe_gamer_en_sesion
    return unless current_gamer.nil?


    #authentication = Authentication.new(provider: "facebook", uid:  , gamer: gamer)
    #authentication.save

    session[:last_params] = params
    redirect_to '/auth/facebook'
  end
end
