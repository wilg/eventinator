# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private
  
  def require_login
    unless logged_in?
      flash[:warning] = "You aren't logged in."
      redirect_to "/"
    end
  end
  
  def logged_in?
    session[:logged_in] == true
  end
  
end
