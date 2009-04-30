class AdminController < ApplicationController
  
  before_filter :authenticate, :only => :login
  
  def index
    if logged_in?
      redirect_to :action => :logout
    else
      redirect_to :action => :login
    end
  end
  
  def login
    session[:logged_in] = true
    redirect_to "/"
  end
  
  def logout
    session[:logged_in] = nil
    redirect_to "/"
  end
  
  protected

  def authenticate
    if APP_CONFIG['perform_authentication']
      authenticate_or_request_with_http_basic do |username, password|
        username == APP_CONFIG['username'] && password == APP_CONFIG['password']
      end
    end
  end
  
  
end
