#!/usr/bin/env ruby

if ENV['RAILS_VERSION'] =~ /^6.0/
  puts "Testing Rails 6.0"
  exit system('cd spec/dummy_6.0 && bundle install --without debug && rails db:reset && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^5/
  puts "Testing Rails #{ENV['RAILS_VERSION']}"
  exit system("cd spec/dummy_#{ENV['RAILS_VERSION']} && bundle install --without debug && rails db:reset && cd ../../ && bundle exec rspec spec")
elsif ENV['RAILS_VERSION'] =~ /^4/
  puts "Testing Rails #{ENV['RAILS_VERSION'].to_i}"
  exit system("cd spec/dummy_#{ENV['RAILS_VERSION'].to_i} && bundle install --without debug && rake db:reset && cd ../../ && bundle exec rspec spec")
else
  puts "Testing Rails 3"
  exit system('cd spec/dummy && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
end
