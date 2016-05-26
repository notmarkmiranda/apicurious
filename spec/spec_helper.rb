require 'simplecov'
SimpleCov.start("rails")
require 'database_cleaner'
require 'omniauth-twitter'
require 'pry'
require 'vcr'


VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

cred = { token:  "12345",
         secret: "67890"}
credentials = OpenStruct.new(cred)
ah   = { screen_name: "notmarkmiranda",
         uid:         "3300701839",
         credentials: credentials }
auth_hash = OpenStruct.new(ah)

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(auth_hash)
OmniAuth.config.add_mock(auth_hash)

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
      # OmniAuth.config.mock_auth[:twitter] = nil
    end
  end
end
