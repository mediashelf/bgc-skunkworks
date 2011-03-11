# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bgc-blacklight_session',
  :secret      => 'c05a352feb8f85c8ba39df7f213008817bcd1649b74d672864e0bc8f5761f16df224c2a6336bde6d2f7be534b336786e0422449142c364a2616be2d154a03dd9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
