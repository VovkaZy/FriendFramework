# frozen_string_literal: false

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
require_relative 'logbook'
require_relative 'constants/constants'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# BSPage is a basic class to inherit for all pages in Page Object at Framework.
# Here we have basic methods, common to all the pages.
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class BSPage
  attr_reader :browser
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  def initialize(browser)
    @browser = browser
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # === ACTION METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Clear all cookies from browser
  def clear_cookies
    Logbook.step('Deleting all cookies... (^.^)' + "\n")
    @browser.manage.delete_all_cookies
  end

  # Get the title of the current page
  #
  # @return [String]
  def title
    @browser.title
    Logbook.message("Page title is #{@browser}")
  end

  # Searching for the element on a page with given locator
  #
  # @return [String]: Founded element
  def find(locator)
    @browser.find_element locator
  end

  # Get to the given url
  #
  # @param [String]: URL needed to open
  def go_to_page(url)
    Logbook.step("Open start page #{url}  :)")
    @browser.get url
    sleep 2

    @browser
  end

  # Get the URL of the current page
  #
  # @return [String]
  def url
    @browser.current_url
  end

  # Closing current page in browser
  def close_page
    Logbook.message('Closing browser page >>')

    if @browser.nil?
      Logbook.error('Page is already closed')
    else
      @browser.close
      Logbook.message('Done! Page closed')
    end
  end

  # To close cookie banner at the bottom of a page
  def close_banner
    Logbook.message('Closing cookie bunner...')
    @browser.execute_script("document.querySelector('ugc-cookie-banner-internal').shadowRoot.querySelector('.close').click()")
  end

  # To close the browser and show common result final result of a test execution
  # with steps, warnings and errors
  def close_browser
    Logbook.step('Stop webdriver. The End of a test:)')
    @browser.quit
    Logbook.publish_results
  end

  # Scrolling to the bottom of the page
  def scroll_to_bottom
    Logbook.step('Scrolling to the bottom of a page')
    @browser.execute_script('window.scrollTo(0, document.body.scrollHeight)')
  end

  # To get the screenshot with the result of test script
  def screenshot
    Logbook.step('Taking a screenshot of a result page')
    @browser.save_screenshot("./screenshots/screenshot - #{Time.now.strftime('%Y-%m-%d %H-%M-%S')}.png")
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # === TEXT METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Clearing text field with a given locator & typing text in it
  def type_text(locator, text)
    Logbook.step("Type text '#{text}' to the input with locator #{locator}")
    find(locator).send_keys(:backspace, text)
  end

  # Get the text content of this element
  #
  # @return [String]
  def text_of_element(locator)
    Logbook.message("Get text of element with locator #{locator}")
    find(locator).text
  end

  # Use to clear the text field content
  #
  # @param locator: Locator of element need to clear
  def clear_text_field(locator)
    find(locator).clear
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # === CLICK METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Clicking on the finding element with given locator
  #
  # @param locator: Locator of element need to click
  def click_on(locator)
    Logbook.message("Click on the element with locator #{locator}")
    find(locator).click
  end

  # Click on element & wait some time
  #
  # @param locator: Locator of element need to click
  #
  # @param sec [Integer]: Waiting time in seconds
  #
  # @param arg [Symbol, String, Integer]: Argument in element locator
  def click_wait(locator, sec, _arg = nil)
    click_on(locator)
    wait(sec)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # === WAIT METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Waiting until the given block returns a true value.
  #
  # @raise [Error::TimeOutError]
  # @return [Object] the result of the block
  def wait_for(seconds = Constants::DEFAULT_WAIT)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end

  # Waiting for page to loaded verifying it with JS using favicon ! == null
  def wait_for_page_to_load(page)
    Logbook.message("Waiting for page #{page} to load...")
    wait_for do
      @browser.execute_script("return document.querySelector('link[rel=\"icon\"]') !== null")
    end
  end

  # Wait some time in seconds
  #
  # @param sec [Integer]: Waiting time
  def wait(sec = 5)
    Logbook.message("Waiting #{sec} sec >>" + "\n")
    sec.instance_of?(Integer) ? sleep(sec) : Logbook.message("Waiting time is not integer: [#{sec}]" + "\n")
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # === VERIFICATION METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Is the element displayed?
  #
  # @return [Boolean]
  def element_displayed?(locator)
    @browser.find_element(locator).displayed?
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  #
  # === ACTIONS WITH ELEMENTS ====
  #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Get element by locator
  #
  # @param locator: Locator of element need to find
  #
  # @param base_element [Symbol, String, Integer]: Argument in element locator
  #
  # @return [Element]
  def get_element(locator, base_element = nil)
    (base_element ? base_element : @browser).find_element(locator)
  end

  #  Get all elements by locator matching the given arguments
  #
  # @param locator: Locator of element need to find
  #
  # @param base_element [Symbol, String, Integer]: Argument in element locator
  #
  # @return [Elements]
  def get_elements(locator, base_element = nil)
    (base_element ? base_element : @browser).find_elements(locator)
  end

  # Check if element with locator is displayed on a page
  def displayed?(locator)
    Logbook.message("Check is element with locator #{locator} displayed?")
    begin
      @browser.find_element(locator).displayed?
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    end
  end

  # Get element text
  #
  # @param locator: Locator of element need to find
  #
  # @param base_element [Symbol, String, Integer]: Argument in element locator
  #
  # @return [String]: Text of define element if element displayed
  def get_element_text(locator, base_element = nil)
    get_element(locator, base_element).text
  end

  # Get elements text
  #
  # @param element [ElementLocator]: Locator of elements need to find
  #
  # @param arg [Symbol, String, Integer]: Argument in elements locator
  #
  # @return [Array<String>]: Text of define element
  def get_elements_text(locator, base_element = nil)
    elements_text = []
    get_elements(locator, base_element).each do |web_element|
      elements_text << web_element.text
    end
    elements_text
  end
end
