#!/usr/bin/env ruby

if ENV['RAILS_VERSION'] =~ /^4/
  system('cd spec/dummy_4 && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
else
  system('cd spec/dummy && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec')
end