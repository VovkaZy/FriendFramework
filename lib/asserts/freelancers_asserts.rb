# frozen_string_literal: true

require_relative '../../lib/logbook'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# FreelancersAsserts module to verify results according to test task
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module FreelancersAsserts
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== METHODS ====
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # To verify that freelancer(s) profile(s) contains keyword
  # Logs all results to STDOUT
  def verify_result_contains_keyword(keyword)
    Logbook.step("Verify freelancer's info contains keyword '#{keyword}'")
    freelancers_arr = !@freelancer_profile.nil? ? [@freelancer_profile] : @freelancers_profiles_arr
    Logbook.step("*********Search for keyword in reelancers info************\n")
    freelancers_arr.each do |freelancer|
      logger_arr = ["Freelancer #{freelancer[:name]}:"]
      logger_arr.append(search_fileds_for_keyword_log(freelancer, keyword)).flatten
      Logbook.message(logger_arr.join("\n") + "\n")
    end
  end
  # To verify which fields of freelancer's profile contains keyword
  # Logs all results to STDOUT
  def verify_freelancer_profile(freelancers)
    Logbook.step("Verify freelancer #{@freelancer_profile[:name]} profile")
    freelancer = freelancers.find { |freelancer| freelancer[:name] == @freelancer_profile[:name] }
    Logbook.message("*****Profile page of #{freelancer[:name]}*****")
    @freelancer_profile.each do |key, value|
      if value.include?(freelancer[key.to_sym])
        Logbook.message("+ Profile field #{key} matches with the same field from preview.")
      else
        Logbook.message("- Profile field #{key} does not match with the same field from preview.")
      end
    end
  end
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ==== PRIVATE METHODS ====
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  private
  # To verify which fields of freelancer's profile contains keyword
  # Logs all results to STDOUT
  def search_fileds_for_keyword_log(freelancer, keyword = nil)
    keyword ||= Constants::KEYWORD
    result_arr = []
    freelancer.each do |key, value|
      next if key == :name
      result_arr << if value.to_s.downcase.include?(keyword.downcase)
                      "+ field '#{key}' contains keyword '#{keyword}'"
                    else
                      "- field '#{key}' does not contain keyword '#{keyword}'"
                    end
    end
    result_arr
  end
end
