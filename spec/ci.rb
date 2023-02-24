#!/usr/bin/env ruby

if ENV['RAILS_VERSION'] =~ /^7.0/
  puts "Not ready to test Rails 7.0"
  exit 1

  puts "Testing Rails 7.0"
  exit system('cd spec/dummy_7.0 &&  bundle config set --local without debug && bundle install && bundle exec rails db:reset && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^6.1/
  puts "Not ready to test Rails 6.1"
  exit 1

  puts "Testing Rails 6.1"
  exit system('cd spec/dummy_6.1 &&  bundle config set --local without debug && bundle install && bundle exec rails db:reset && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^6.0/
  puts "Testing Rails 6.0"
  exit system('cd spec/dummy_6.0 &&  bundle config set --local without debug && bundle install && bundle exec rails db:reset && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^5/
  puts "Testing Rails #{ENV['RAILS_VERSION']}"
  exit system("cd spec/dummy_#{ENV['RAILS_VERSION']} && bundle config set --local without debug && bundle install && bundle exec rails db:reset && cd ../../ && bundle exec rspec spec")
elsif ENV['RAILS_VERSION'] =~ /^4/
  puts "Testing Rails #{ENV['RAILS_VERSION'].to_i}"
  bundler1_version = "1.17.3"
  exit system("cd spec/dummy_#{ENV['RAILS_VERSION'].to_i} && gem install bundler -v #{bundler1_version} && bundle _#{bundler1_version}_ install --without debug && bundle _#{bundler1_version}_ exec rake db:reset && cd ../../ && bundle _#{bundler1_version}_ exec rspec spec")
else
  puts "Testing Rails 3"
  exit system('cd spec/dummy && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
end
