require 'icalendar'

class IcalController < ApplicationController

  caches_page :competitions

  def upcoming
    # headers['Content-Type'] = "text/calendar"
    
    cal = Icalendar::Calendar.new
    
    # cal.timezone do
    #   timezone_id             "US/Pacific"
    # 
    #   daylight do
    #     timezone_offset_from  "-0800"
    #     timezone_offset_to    "-0700"
    #     timezone_name         "PST"
    #     dtstart               "19870405T020000"
    #     add_recurrence_rule   "FREQ=YEARLY;UNTIL=20060402T100000Z;BYMONTH=4;BYDAY=1SU"
    #   end
    # 
    #   standard do
    #     timezone_offset_from  "-0700"
    #     timezone_offset_to    "-0800"
    #     timezone_name         "PST"
    #     dtstart               "19621028T020000"
    #     add_recurrence_rule   "FREQ=YEARLY;UNTIL=20061029T090000Z;BYMONTH=10;BYDAY=-1SU"
    #   end
    # end
    
    
    Event.displayable.all.each do |my_event|
      ievent = Icalendar::Event.new
      ievent.start = my_event.start_date
      ievent.end = my_event.start_date + 2.hours 
      ievent.summary = my_event.name
      ievent.description = my_event.description
    
      cal.add ievent
    end
    
    render :text => cal.to_ical, :layout => false
    
  end

  
  
end
