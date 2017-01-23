# README

Documentation on:
https://app.swaggerhub.com/api/keernel/Test2/1.0.0

* Ruby version
  2.4.0

* Configuration
  bundle install

* Database creation
  rake db:create
  rake db:migrate

* How to run the test suite
  rspec -f doc

* Services (job queues, cache servers, search engines, etc.)
  redis-server
  sidekiq
  job execution with HerokuScheduler: https://scheduler.heroku.com
  (for sample demonstration only)

* Deployment instructions
  heroku
