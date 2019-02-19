# frozen_string_literal: false

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
require 'rubygems'
require 'selenium-webdriver'
require_relative 'logbook'
require_relative 'constants/constants'
require_relative 'pages/home_page'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Friend is a class which starts a WebDriver session & provides connection
# between Tests & Pages in Page Object at this Framework.
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class Friend
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== METHODS ====
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Method to start the WebDriver session & prepare the browser to work with
  #
  # @returns a HomePage instance with a webdriver state
  def self.open_browser(browser = nil)
    args = %w[ignore-certificate-errors disable-popup-blocking
              disable-translate disable-web-security
              disable-plugins-discovery start-maximized]
    options = Selenium::WebDriver::Chrome::Options.new(args: args)
    Logbook.step('Setup webdriver...')
    driver = if browser.nil?
               browser = Constants::DEFAULT_BROWSER
               Selenium::WebDriver.for browser
             else
               Selenium::WebDriver.for browser.to_sym, options: options
             end
    Logbook.message("* < #{browser} > up & running *\n")
    driver.manage.timeouts.implicit_wait = 30
    Logbook.message(" < #{browser} > is waiting to all needed sources be loaded")
    HomePage.new(driver)
  end
end
