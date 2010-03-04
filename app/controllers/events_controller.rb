class EventsController < ApplicationController
  
  before_filter :require_login, :only => [:destroy]
  
  def index
    params[:all] ? @events = Event.all : @events = Event.displayable.all
    @events = @events.paginate(:per_page => 30, :page => params[:page])
    @events.delete_if {|event| event.start_date.nil? } 
    @event_days = @events.group_by { |event| event.start_date.beginning_of_day }
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      edit_url = url_for(:action => :edit, :controller => :events, :id => @event.id, :secret => @event.secret_code)
      flash[:notice] = "Your event has been added!<br><br>Save this link to edit your event:<br> <a href=\"#{edit_url}\">#{edit_url}</a>"
      redirect_to @event
    else
      render :action => 'new'
    end
  end
  
  before_filter :require_secret, :only => [:edit, :update]
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      if logged_in?
        flash[:notice] = "Successfully updated event."
      else
        edit_url = url_for(:action => :edit, :controller => :events, :id => @event.id, :secret => @event.secret_code)
        flash[:notice] = "Your event has been updated!<br><br>Save this link to edit your event:<br> <a href=\"#{edit_url}\">#{edit_url}</a>"
      end
      redirect_to @event
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to events_url
  end
  
  private
  
  def require_secret
    unless params[:secret] == Event.find(params[:id]).secret_code
      flash[:warning] = "Sorry, you can't edit that!"
      redirect_to "/"
    end
  end
  
end
