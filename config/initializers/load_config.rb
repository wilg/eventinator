# config/initializers/load_config.rb
APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/eventinator.yml")