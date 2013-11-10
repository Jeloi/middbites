source 'http://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
# gem 'bootstrap-sass', '2.3.1.0'
gem 'bcrypt-ruby'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'cancan'
gem 'nokogiri'
gem 'acts-as-taggable-on'
gem 'rails3-jquery-autocomplete', git: 'https://github.com/francisd/rails3-jquery-autocomplete'

# gem 'jquery-turbolinks'

gem 'zurb-foundation'
gem 'omniauth-facebook', '1.4.0'
gem 'friendly_id', '5.0.0.beta4'
# gem 'nested_form'
# gem 'chosen-rails', github: 'Jeloi/chosen-rails'
gem 'chosen-rails'
gem 'compass-rails', github: 'Compass/compass-rails'
# gem 'select2-rails'

gem 'mysql2'

# For making development life better
gem 'hirb'
gem 'quiet_assets'

group :development, :test do
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
  gem 'pg', '0.15.1'
end