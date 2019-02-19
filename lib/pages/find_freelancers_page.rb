# frozen_string_literal: true

require_relative 'freelancer_profile'
require_relative '../asserts/freelancers_asserts'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# FindFreelancersPage is a class to work with Find Freelancers page.
# It contains locators, methods to interact with, element presence verification
# on the Find Freelancers page according to test task.
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class FindFreelancersPage < BSPage
  include FreelancersAsserts
  attr_accessor :browser

  def initialize(browser)
    @browser = browser
    @freelancers_profiles_arr = []
  end
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== CONSTANTS WITH LOCATORS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  FR_PROFILE_NAME =   { css: 'h4.d-xl-block a.freelancer-tile-name'     }.freeze
  FR_PROFILE_TITLE =  { css: 'h4[data-qa="tile_title"]'                 }.freeze
  FR_PROFILE_DESCR =  { css: 'div.d-none p[data-qa="tile_description"]' }.freeze

  SKILLS =                 { css: 'div.p-lg-top-agg-sm-lg>span'        }.freeze
  PAGINATION =             { css: 'label[class="p-sm-right"]'          }.freeze
  SEARCH_RESULTS_SECTION = { css: 'section.air-card-hover_tile'        }.freeze
  CLOSE_COOKIE_BANNER =    { css: 'up-c-close-icon.hydrated'           }.freeze
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== METHODS ====
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # [6]  Parse the 1st page with search results
  #
  # @returns [@freelancers] array of hashes
  def parse_result_from_first_page
    scroll_to_bottom
    wait_for { displayed?(PAGINATION) }
    Logbook.step('*** >>> Saving search results... <<< ***')

    @freelancers_sections_array = get_elements(SEARCH_RESULTS_SECTION)
    @freelancers_sections_array.each do |element|
      @freelancers_profiles_arr <<
        {
          name: get_element(FR_PROFILE_NAME, element).text,
          title: get_element(FR_PROFILE_TITLE, element).text,
          description: get_element(FR_PROFILE_DESCR, element).text,
          skills: skills_list(element)
        }
    end
    @freelancers_profiles_arr
  end
  # Get skills from profile
  #
  # @return [skills_list] array of strings
  def skills_list(freelancer_elt)
    skills_list = []
    skills_elts_arr = get_elements(SKILLS, freelancer_elt)
    skills_elts_arr.each do |skill_elt|
      skills_list << skill_elt.text
    end
    skills_list
  end
  # Counts how many freelancers in an array
  #
  # @return [Integer]
  def freelancers_count
    @freelancers_profiles_arr.count
  end
  # Click on random freelancer's title
  def choose_random_freelancer
    @choosen_freelancer_name = @freelancers_profiles_arr[rand(0...freelancers_count)][:name]
  end
  # [8]  Click on random freelancer's title
  # [9]  Get into that freelancer's profile
  #
  # @return {FreelancerProfile instance} hash with
  def open_choosen_freelancer_profile(freelancer_name = nil)
    close_banner
    profile_name = freelancer_name || @choosen_freelancer_name
    Logbook.step("Navigate to freelancer '#{profile_name}' profile page...")
    click_on(link: profile_name.to_s)
    wait_for_page_to_load(FreelancerProfile.name)
    FreelancerProfile.new(@browser)
  end
end
