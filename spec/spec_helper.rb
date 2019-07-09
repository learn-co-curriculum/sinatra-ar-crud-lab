ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

begin
  fi_check_migration
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.order = 'default'
end

ActiveRecord::Base.logger.level = 1

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app