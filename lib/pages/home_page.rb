# frozen_string_literal: false

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
require_relative '../bspage'
require_relative 'find_freelancers_page'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# HomePage is a class to work with Home page https://www.upwork.com
# It contains locators & method to interact with the Home page
# according to test task.
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class HomePage < BSPage
  attr_accessor :browser

  def initialize(browser)
    @browser = browser
  end
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== CONSTANTS WITH LOCATORS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  FIND_FREELANCERS        = { xpath: './/div[contains(@class,"d-none")]//input[@name="q"]'             }.freeze
  MAGNIFYING_GLASS_BUTTON = { xpath: './/div[contains(@class,"d-none")]//button[contains(.,"Submit")]' }.freeze
  #
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== METHODS ====
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Use to locate Find Freelancers field at the left top on the page,
  # put `<keyword>` in it & submit search with the magnifying glass button
  #
  # @return [FindFreelancerPage] instance with search results & webdriver state
  def find_freelancer_with(keyword)
    click_wait FIND_FREELANCERS, 1
    type_text FIND_FREELANCERS, keyword
    wait 1
    click_wait MAGNIFYING_GLASS_BUTTON, 1
    wait_for_page_to_load FindFreelancersPage.name
    FindFreelancersPage.new(@browser)
  end
end
