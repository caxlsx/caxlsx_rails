#!/usr/bin/env ruby

if ENV['RAILS_VERSION'] =~ /^6.0/
  puts "Testing Rails 6.0"
  exit system('cd spec/dummy_6.0 && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^5.2/
  puts "Testing Rails 5.2"
  exit system('cd spec/dummy_5.2 && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^5.1/
  puts "Testing Rails 5.1"
  exit system('cd spec/dummy_5.1 && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^5/
  puts "Testing Rails 5"
  exit system('cd spec/dummy_5 && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
elsif ENV['RAILS_VERSION'] =~ /^4/
  puts "Testing Rails 4"
  exit system('cd spec/dummy_4 && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
else
  puts "Testing Rails 3"
  exit system('cd spec/dummy && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
end
