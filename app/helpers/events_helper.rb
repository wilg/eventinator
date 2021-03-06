module EventsHelper
  
  def legit_edit_link(event)
    url_for :action => :edit, :controller => :events, :id => event.id, :secret => event.secret_code
  end
  
  def fee_format(fee)
    h(fee).gsub(", ", "<br>")
  end
  
end
