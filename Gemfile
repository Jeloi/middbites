source 'http://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.2'
# gem 'bootstrap-sass', '2.3.1.0'
gem 'bcrypt-ruby'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'cancan'
gem 'nokogiri'
gem 'acts_as_commentable'
gem 'carrierwave'
gem 'rmagick'

gem 'devise'

gem 'autoprefixer-rails'

# gem 'fog'
# gem 'carrierwave_direct'
# gem 'sidekiq'


gem 'jquery-turbolinks'

gem 'font-awesome-rails'

gem 'foundation-rails', github: 'Jeloi/foundation-rails'
# gem 'foundation-rails'  # use this when commented xlarge columns is resolved
gem 'omniauth-facebook', '1.4.0'
gem 'friendly_id', '5.0.0.beta4'
# gem 'nested_form'
# gem 'chosen-rails', github: 'Jeloi/chosen-rails'
gem 'chosen-rails'
gem 'compass-rails', github: 'Compass/compass-rails'

# Search gems
gem 'sunspot_solr', github: 'sunspot/sunspot', branch: 'master'
gem 'sunspot_rails', github: 'sunspot/sunspot', branch: 'master'
 # Social media helper gem
 gem "social-buttons", git: "git://github.com/kristianmandrup/social-buttons.git"

gem 'figaro'

gem 'mysql2'


group :development, :test do
  # For making development life better
  gem 'hirb'
  gem 'quiet_assets'
  gem 'sqlite3', '1.3.7'
  gem 'rspec-rails'
  # The following optional lines are part of the advanced setup.
  gem 'guard-rspec'
  gem 'childprocess', '0.3.6'
  gem 'annotate'
  gem 'shoulda'

  gem 'guard-zeus'
  gem 'zeus' 
  gem 'factory_girl_rails'
  gem 'sunspot_test'

  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'

  # Performance testing gems. Need to troubleshoot
  # gem 'rails-perftest'
  # gem 'ruby-prof'
  # gem 'test-unit'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver' # for integration js testing
  gem 'capybara-webkit'
  gem 'launchy' # preview web pages during tests
  gem 'factory_girl_rails' # generate factories for test data

  gem 'cucumber-rails', '1.3.0', :require => false
  gem 'database_cleaner', '1.0.1'

  # Notifications on Linux
  # gem 'libnotify', '0.8.0'
  gem 'terminal-notifier-guard'

end

gem 'sass-rails', '4.0.0.rc2'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '2.2.1'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  # gem 'pg', '0.15.1'
  gem 'rails_12factor'
end