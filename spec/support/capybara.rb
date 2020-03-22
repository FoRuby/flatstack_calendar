# Capybara.register_driver :selenium_chrome_headless do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: {
#       args: %w[
#         headless
#         enable-features=NetworkService
#         NetworkServiceInProcess
#       ]
#     }
#   )
#
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :chrome,
#     desired_capabilities: capabilities
#   )
# end

Capybara.javascript_driver = :selenium_headless
