# frozen_string_literal: false

# Test Case ___name____
#
# Find Freelancers with `<keyword>` & verify that profile contains `<keyword>`
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Created by ZUBARIEV, Volodymyr 09-16.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# == STEPS FOR TEST ==
# - - - - - - - - - - -
# [1]  Run `<browser>`
# [2]  Clear `<browser>` cookies
# [3]  Go to https://www.upwork.com
# [4]  Focus onto "Find freelancers"
# [5]  Enter `<keyword>` into the search input right from the dropdown
#      & submit it (click on the magnifying glass button)
# [6]  Parse the 1st page with search results:
#      store info given on the 1st page of search results as structured data
#      of any chosen type (i.e. hash of hashes or array of hashes,
#      whatever structure handy to be parsed).
# [7]  Make sure at least one attribute (title, overview, skills, etc)
#      of each item (found freelancer) from parsed search results
#      contains `<keyword>`.
#      Log in stdout which freelancers & attributes contain `<keyword>`
#      & which do not.
# [8]  Click on random freelancer's title
# [9]  Get into that freelancer's profile
# [10] Check that each attribute value is equal to one of those stored
#      in the structure created in #67
# [11] Check whether at least one attribute contains `<keyword>`
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

require_relative '../lib/friend'

# [1]  Run `<browser>`
page = Friend.open_browser(:firefox)

# [2]  Clear `<browser>` cookies
page.clear_cookies

# [3]  Go to https://www.upwork.com
page.go_to_page 'https://www.upwork.com'

# [4]  Focus onto "Find freelancers"
#
# [5]  Enter `<keyword>` into the search input right from the dropdown
#      & submit it (click on the magnifying glass button)
freelancers_search_result = page.find_freelancer_with 'selenium'

# [6]  Parse the 1st page with search results
freelancers_search_result.parse_result_from_first_page

# [7]  Make sure at least one attribute (title, overview, skills, etc)
#      of each item (found freelancer) from parsed search results
#      contains `<keyword>`.
#      Log in stdout which freelancers & attributes contain `<keyword>`
#      & which do not.
freelancers_search_result.verify_result_contains_keyword 'selenium'

# [8]  Click on random freelancer's title
freelancers_search_result.choose_random_freelancer

# [9]  Get into that freelancer's profile
freelancer_profile = freelancers_search_result.open_choosen_freelancer_profile

# [10] Check that each attribute value is equal to one of those stored
#      in the structure created in #67
# [11] Check whether at least one attribute contains `<keyword>`
freelancer_profile.verify_result_contains_keyword 'selenium'

# [12] Taking s screenshot of result page
freelancer_profile.screenshot

# [13] Wait a little bit to see the result page
freelancer_profile.wait 10

# [14] Close the browser
freelancer_profile.close_browser
