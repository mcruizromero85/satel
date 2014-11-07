class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :signed_in?

  def current_gamer  
    if @current_gamer != nil || session[:gamer_id] != nil then
      @current_gamer ||= Gamer.find(session[:gamer_id])  
    end 
    
  end

  def signed_in?
    !!current_gamer
  end

  helper_method :current_gamer, :signed_in?

  def current_gamer=(gamer)
    @current_gamer = gamer
    session[:gamer_id] = gamer.id
  end

  def revisa_si_existe_gamer_en_sesion
    if current_gamer == nil then
      session[:last_url_pre_login] = '/'
      if ENV["RAILS_ENV"] == 'test'
        redirect_to '/auth/developer'
      else
        redirect_to '/auth/facebook'
      end  
    end
  end

end
