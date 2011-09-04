# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path('../dummy/config/environment', __FILE__)
require "rails/test_help"
require "rspec/rails"
require "database_helpers"
require 'player_helpers'

include DatabaseHelpers
# Run any available migration
puts 'Setting up database...'
drop_all_tables
migrate_database
Rails.backtrace_cleaner.remove_silencers!
Webrat.configure do |config|
  config.mode = :rails
end


RSpec.configure do |config|
  config.include PlayerHelpers  
  config.include Warden::Test::Helpers
  config.include RSpec::Matchers
  config.include RailsAdmin::Engine.routes.url_helpers
  config.include Webrat::Matchers
  config.include Webrat::HaveTagMatcher
  config.include DatabaseHelpers  
  config.before(:each) do
    RailsAdmin::AbstractModel.new("Player").destroy_all!
    RailsAdmin::AbstractModel.new("User").destroy_all!

    user = RailsAdmin::AbstractModel.new("User").create(
      :email => "test@test.com",
      :password => "test1234"
    )

    login_as user
  end

  config.after(:each) do
    RailsAdmin.test_reset!
    Warden.test_reset!
  end
end
