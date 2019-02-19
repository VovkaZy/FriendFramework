# frozen_string_literal: true

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Constants module to work with Home page https://www.upwork.com
# It contains locators and methods to interact with the Home page
# consider to test task. See the description of methods below
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

module Constants
  DEFAULT_BROWSER = :firefox
  DEFAULT_WAIT = 120
  BASE_URL = ENV.fetch('BASE_URL') { 'https://www.upwork.com' }
  KEYWORD = ENV.fetch('KEYWORD') { 'Selenium' }
end
