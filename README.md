# README


This is a sample app to revise rails basics

dependencies

* ruby 2.6.7
* rails 6.1.3
* mysql@5.7
* redis
* bundler


Clone this repo
1. install rvm curl -sSL https://get.rvm.io | bash and rvm install 2.6.7
2. if homebrew support is present then ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
3. gem install bundler
4. install mysql@5.7,  brew install mysql@5.7
5. gem install rails
6. Since Rails 6, Webpacker is the default JavaScript compiler. So you'll also have to set it up before starting your Rails serve
npm install --global yarn
rails webpacker:install
7. install redis, brew install redis, brew services start redis
8. CREATE DATABASE sample_database;
9. rake db:migrate
10. bundle install
11. rails s

Test cases:

bundle exec rspec spec/sms_controller_spec.rb

RAILS_ENV=test bundle exec rspec spec/data_validator_spec.rb
RAILS_ENV=test bundle exec rspec spec/number_usage_throttler_spec.rb
RAILS_ENV=test bundle exec rspec spec/sms_validator_spec.rb
RAILS_ENV=test bundle exec rspec spec/sms_util_spec.rb
