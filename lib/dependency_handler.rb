module DependencyHandler
  protected

  @@default_page_title = "Website"

  # Add Javascript or CSS dependencies into the layout
  #
  # Place this on a partial or action, and place get_dependencies
  # in the layout, and boom, you have nicely formatted and modular assets
  #
  # Example:
  #  dependencies :css => :home, :js => [:prototype, :home]
    
  def dependencies(options)
    if not options[:css].blank?
      if @additional_stylesheets
          @additional_stylesheets << options[:css]
      else
        @additional_stylesheets = [*options[:css]]
      end
      @additional_stylesheets.flatten!
      @additional_stylesheets.uniq!
    end
    
    if not options[:js].blank?
      if @additional_javascripts
        @additional_javascripts << options[:js]
      else
        @additional_javascripts = options[:js].to_a
      end
      @additional_javascripts.flatten!
      @additional_javascripts.uniq!
    end
  end
  
  # Alias of dependencies
  def add_dependencies(options)
    dependencies(options)
  end
  
  # Place this in the layout and use dependencies(options) to add assets to the layout modularly
  def get_dependencies
    html = ""
    delimiter = "\n\t"
    if @additional_stylesheets
      for stylesheet in @additional_stylesheets
      	html << delimiter << stylesheet_link_tag(stylesheet.to_s, :media => "all")
    	end
  	end
  	if @additional_javascripts
    	for script in @additional_javascripts
        html << delimiter << javascript_include_tag(script.to_s)
  	  end
    end
  	html
  end
  
  # Used at the begining of a view to tell the layout to use the page title.
  # should_prefix determines whether the site name will be prepended to the final output.
  def page_title(title, should_prefix = true)
    @unprefixed_title = title
    should_prefix ? @page_title = prefix(title) : @page_title = title
    "<h1>#{title}</h1>"
  end
  
  # Alias of page_title
  def title(title, should_prefix = true)
    page_title(title, should_prefix)
  end
  
  # Helper method for placing multiple flashes into the layout
  #
  # Accepts only flash[:notice, :warning, :message]
  def flashes
    html = "\n"
		for name in [:notice, :warning, :message]
  		if flash[name]
    		html << "<div class=\"flash #{name} clearfix\">#{flash[name]}</div>"
      end
    end
    html
  end
  
  # Use to pass the page title into the layout
  # Use page_title to set the page title for a particular page
  def get_page_title
    @page_title ? @page_title : prefix(nil)
  end
  
  @@page_title_delimiter = "-"
  # Helper method to prefix the page title with the site name. Usually you wouldn't call this directly
  def prefix(x)
    delimiter = @@page_title_delimiter
    the_prefix = ""
    if devmode?
      the_prefix = "[DEV] "
    end
    if x.nil?
      "#{the_prefix} #{@@default_page_title}"
    else
      "#{the_prefix} #{@@default_page_title} #{delimiter} #{x}"
    end
  end
  
  # Is the project running in the development environment?
  def devmode?
    ENV["RAILS_ENV"] == "production" ? false : true
  end
  
end