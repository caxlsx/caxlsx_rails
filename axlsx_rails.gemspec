$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "axlsx_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "axlsx_rails"
  s.version     = AxlsxRails::VERSION
  s.authors     = ["Noel Peden"]
  s.email       = ["noel@peden.biz"]
  s.homepage    = "http://github.com/straydogstudio/axlsx_rails"
  s.summary     = "A simple rails plugin to provide an xlsx renderer using the axlsx gem."
  s.description = "This plugin provides a Rails 3 renderer and template handler for xlsx using the axlsx gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + Dir['[A-Z]*']
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "axlsx"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end
