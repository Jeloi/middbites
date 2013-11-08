# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# require 'rspec/autorun'
require 'omniauth'

# require 'capybara/rspec'

# Capybara.javascript_driver = :default

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # Database Cleaner, because we're not using transactional fixtures (because of selenium)
  config.before(:suite) do  
    DatabaseCleaner.strategy = :truncation  
  end  
    
  config.before(:each) do  
    DatabaseCleaner.start  
  end  
    
  config.after(:each) do  
    DatabaseCleaner.clean  
  end  

  # config.after(:all) do
  #   DatabaseCleaner.clean_with(:truncation)
  # end


  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Omniauth
  OmniAuth.config.test_mode = true
    
  omniauth_hash = { 'uid' => '12345', 'nickname' => 'testuser', 'credentials' => { 'token' => 'umad', 'secret' => 'bro?', 'expires_at' => Time.at(Time.now) } }
  facebook_hash = {
                 :email => "example_man@example.com",
                 :first_name => "Jeremy",
                 :last_name => "Ho",
                 :name => "Jeremy Ho"
               }
    
  OmniAuth.config.add_mock(:twitter, omniauth_hash)
  OmniAuth.config.add_mock(:foursquare, omniauth_hash)
  OmniAuth.config.add_mock(:facebook, omniauth_hash.merge('info'=> facebook_hash)) # Facebook has 'real-user' attributes, add them here if need be
   
  # config.include Devise::TestHelpers, :type => :controller
  config.include FactoryGirl::Syntax::Methods
end
