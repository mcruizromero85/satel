# Load the Rails application.
require File.expand_path('../application', __FILE__)
require_relative '../lib/edr'

# Initialize the Rails application.
Satel::Application.initialize!

Capybara.app_host = 'http://192.168.56.1:3000/'

Edr::Registry.define do
  map Torneo, TorneoData
end
