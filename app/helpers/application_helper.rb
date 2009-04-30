# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  include DependencyHandler
  @@default_page_title = APP_CONFIG['site_name']
  
  # Makes the date into an easy to read format
  def readable_date(date, include_today = false)
    if !date || date.blank?
      return "Unknown"
    end
    
    string_date = date.strftime("%b %d, %I:%M%p")
    todays_date = Date.today
    yesterdays_date = Date.today - 1
    tomorrow = Date.today + 1
    
    include_today ? today_text = "Today, " : today_text = ""
    
    string_date = string_date.gsub(/#{todays_date.strftime('%b %d')},/, today_text)
    string_date = string_date.gsub(/#{yesterdays_date.strftime('%b %d')}/, 'Yesterday')
    string_date = string_date.gsub(/#{tomorrow.strftime('%b %d')}/, 'Tomorrow')
    string_date.gsub!(/ 0(\d\D)/, ' \1') 
    string_date.gsub!(/AM/, 'am')
    string_date.gsub!(/PM/, 'pm') 
    return string_date
  end
  
  def readable_time(date)
    if !date || date.blank?
      return "Unknown"
    end
    
    string_date = date.strftime("%I:%M%p")
    string_date.gsub!(/0(\d\D)/, ' \1') 
    string_date.gsub!(/AM/, 'am')
    string_date.gsub!(/PM/, 'pm') 
    return string_date
  end
  
  def pretty_day(date)
    if date.today?
      "Today"
    elsif tomorrow? (date)
      "Tomorrow"
    else
      date.strftime("%A, %b %d").sub(" 0", " ") 
    end
  end

  def tomorrow?(date)
    date.to_date == ::Date.current + 1
  end

  
  
  def pretty_url(url)
    url.sub("http://", "").sub("https://", "").sub("www.", "").gsub(/\/+$/, "")
  end
  
  def logged_in?
    session[:logged_in] == true
  end
  
  def admin_area(&block)
    if logged_in?
      concat content_tag(:div, capture(&block), :class => 'admin')
    end
  end
  
  def footer_area(&block)
    concat content_tag(:div, capture(&block), :class => 'footer_bar')
  end
  
end
