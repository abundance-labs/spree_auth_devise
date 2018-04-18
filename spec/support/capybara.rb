require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

RSpec.configure do |_config|
  Capybara.save_and_open_page_path = ENV['CIRCLE_ARTIFACTS'] if ENV['CIRCLE_ARTIFACTS']

  Capybara.register_driver(:selenium_chrome_headless) do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[no-sandbox headless disable-gpu window-size=1024,768] }
    )

    Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
  end

  Capybara.javascript_driver = :selenium_chrome_headless

  # Capybara.register_driver :chrome do |app|
  #   Capybara::Selenium::Driver.new app,
  #     browser: :chrome,
  #     options: Selenium::WebDriver::Chrome::Options.new(args: %w[disable-popup-blocking headless disable-gpu window-size=1920,1080])
  # end

  # Capybara.javascript_driver = :chrome
end
