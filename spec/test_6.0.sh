export RAILS_ENV=test

for version in 6.0
do
  echo "Testing Rails version " $version
  rm Gemfile.lock
  if [ -f Gemfile.lock.$version ];
  then
    echo Reusing Gemfile.lock.$version
    cp Gemfile.lock.$version Gemfile.lock
  fi
  rm spec/dummy_6.0/db/test.sqlite3
  export RAILS_VERSION=$version
  spec/ci.rb
  cp Gemfile.lock Gemfile.lock.$version
done
