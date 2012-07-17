$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "axlsx_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "axlsx_rails"
  s.version     = AxlsxRails::VERSION
  s.authors     = ["Noel Peden"]
  s.email       = ["noel@peden.biz"]
  s.homepage    = "https://github.com/straydogstudio/axlsx_rails"
  s.summary     = "A simple rails plugin to provide an xlsx renderer using the axlsx gem."
  s.description = "This plugin provides a Rails 3 renderer and template handler for xlsx using the axlsx gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + Dir['[A-Z]*'] - ['Guardfile']
  s.test_files = Dir["spec/**/*"] + ['Guardfile']

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "axlsx"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "capybara"
  s.add_development_dependency "acts_as_xlsx"
  s.add_development_dependency "roo"
  s.add_development_dependency "sqlite3"
end
