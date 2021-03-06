require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
ENV['OTP_SECRET'] ||= '9c83b88256513c15eadf4b08b5dbac83a8c602954d9f577aa146368d6'

require File.expand_path('../dummy/config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda-matchers'
require 'ffaker'

RSpec.configure do |config|
  config.filter_run focus: true
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = false

  config.mock_with :rspec do |mock|
    mock.syntax = [:should, :expect]
  end

  config.order = :random
  Kernel.srand(config.seed)
end

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }
