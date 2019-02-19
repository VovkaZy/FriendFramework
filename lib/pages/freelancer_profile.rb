# frozen_string_literal: true

require_relative '../asserts/freelancers_asserts'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# FreelancerProfile is a class to work with Freelancer profile page.
# It contains locators, methods to interact with, element presence verification
# on the Freelancer profile page according to test task.
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class FreelancerProfile < BSPage
  include FreelancersAsserts
  attr_reader :freelancer_profile
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== CONSTANTS WITH LOCATORS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  FR_PROFILE_NAME =       { css: 'div.media h2>span'  }.freeze
  FR_PROFILE_TITLE =      { class: 'fe-job-title'     }.freeze
  FR_PROFILE_DESCR =      { class: 'cfe-overview'     }.freeze
  PROFILE_SKILLS =        { class: 'o-profile-skills' }.freeze
  COMPANY_PROFILE_NAME =  { css: 'h2.m-xs-bottom'     }.freeze
  COMPANY_PROFILE_TITLE = { css: 'h3.m-sm-bottom'     }.freeze
  COMPANY_PROFILE_DESCR = { css: 'div.break'          }.freeze
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  def initialize(browser)
    super
    @freelancer_profile = freelancer_profile_page_text
  end
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== PRIVATE METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  private

  # To get text from profile fields
  #
  # @returns {} with element's text as a value
  def freelancer_profile_page_text
    {
      name: displayed?(FR_PROFILE_NAME) ?
              text_of_element(FR_PROFILE_NAME) :
                text_of_element(COMPANY_PROFILE_NAME),
      title: displayed?(FR_PROFILE_TITLE) ?
               text_of_element(FR_PROFILE_TITLE) :
                 text_of_element(COMPANY_PROFILE_TITLE),
      description: displayed?(FR_PROFILE_DESCR) ?
                     text_of_element(FR_PROFILE_DESCR) :
                       text_of_element(COMPANY_PROFILE_DESCR),
      skills: get_elements_text(PROFILE_SKILLS)
    }
  end
end
