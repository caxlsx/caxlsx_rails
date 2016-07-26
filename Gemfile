source "http://rubygems.org"

# Declare your gem's dependencies in axlsx_rails.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

ENV["RAILS_VERSION"] ||= '4.2'

case ENV['RAILS_VERSION']
when '5.0'
  gem 'rails', "~> 5.0.0"
  gem 'responders', '~> 2.0'
when '4.2'
  gem 'rails', "~> 4.2.0"
  gem 'responders', '~> 2.0'
when '4.1'
  gem 'rails', "~> 4.1.0"
when '4.0'
  gem 'rails', "~> 4.0.0"
when '3.1', '3.2'
  gem 'rails', "~> #{ENV['RAILS_VERSION']}.0"
end

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem "thin"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.
gem 'acts_as_xlsx', git: 'git://github.com/straydogstudio/acts_as_xlsx.git'
gem 'capybara', '~> 2.1'

# To use debugger
# gem 'pry-debugger'
