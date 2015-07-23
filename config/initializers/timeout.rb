


# Set the ENV variable to the number of seconds - 0 = off
Rack::Timeout.timeout = Integer(ENV['RAILS_RACK_TIMEOUT'] || 0)
Rack::Timeout.wait_timeout = Integer(ENV['RAILS_RACK_WAIT_TIMEOUT'] || 0)