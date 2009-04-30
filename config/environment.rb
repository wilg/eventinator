# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  # Loading other files
  config.load_paths += Dir["#{RAILS_ROOT}/app/models/**/**"]
  
  # Active Record
  config.active_record.timestamped_migrations = false

  # Time Zone
  config.time_zone = "Pacific Time (US & Canada)"
  config.active_record.default_timezone = :utc
  
  # Gems
  config.gem "calendar_date_select"
  config.gem "rmagick"
  config.gem 'mislav-will_paginate', :version => '~> 2.3.8', :lib => 'will_paginate', :source => 'http://gems.github.com'
  
end