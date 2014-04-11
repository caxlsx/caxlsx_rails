#!/usr/bin/env sh
if [ "$RAILS_VERSION" == "4.0" ]
then
  cd spec/dummy_4 && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec
else
  cd spec/dummy && bundle install --without debug && bundle exec rake db:create && bundle exec rake db:migrate && cd ../../ && bundle exec rspec spec
fi
