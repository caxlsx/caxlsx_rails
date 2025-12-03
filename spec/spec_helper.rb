ENV["RAILS_ENV"] ||= "test"

# Set up bundle to use gems
require 'bundler/setup'
Bundler.setup

# Require Rails
require 'rails'

# Require the test app's environment
require 'rails_app/config/environment'

# Set up test gems
require 'rspec/rails'
require 'capybara/rspec'
require 'roo'
require 'debug'

Dir[Rails.root.join("../../spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

# TODO: move to the support folder
module ::RSpec::Core
  class ExampleGroup
    include Capybara::DSL
    include Capybara::RSpecMatchers
  end
end
