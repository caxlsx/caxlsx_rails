require 'coveralls'
Coveralls.wear!

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] = 'test'
if ENV['RAILS_VERSION'] =~ /^5/
  puts "Testing Rails 5"
  require File.expand_path("../dummy_5/config/environment", __FILE__)
elsif ENV['RAILS_VERSION'] =~ /^4/
  puts "Testing Rails 4"
  require File.expand_path("../dummy_4/config/environment", __FILE__)
else
  puts "Testing Rails 3"
  require File.expand_path("../dummy/config/environment", __FILE__)
end
require 'bundler'
require 'bundler/setup'
require 'rspec/rails'
require 'capybara/rspec'
require 'axlsx_rails'
require 'acts_as_xlsx'
require 'roo'
require 'pry'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.color = true
  config.formatter     = 'documentation'
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

module ::RSpec::Core
  class ExampleGroup
    include Capybara::DSL
    include Capybara::RSpecMatchers
  end
end

def mime_type
  Rails.version.to_f >= 5 ? Mime[:xlsx] : Mime::XLSX
end
