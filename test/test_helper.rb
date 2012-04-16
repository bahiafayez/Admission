require 'simplecov'
SimpleCov.start


ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

def current_path
  URI.parse(current_url).path
end


class ActionController::TestCase
  include Devise::TestHelpers
  #fixtures :users
end


Webrat.configure do |config|
  config.mode = :rack
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
