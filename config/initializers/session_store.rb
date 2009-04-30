# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Eventinator_session',
  :secret      => '0fad1231aa2031bc55de62fdc8ad37c6457ef47a9b539897eda9a19119198985b4af661b5e0e3409418c51bf3202bf588b5f685c5220cb03b9c724cf90d83f9a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
