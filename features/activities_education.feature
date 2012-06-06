Feature: Describe activities page
  
  Scenario: Page must be available
    And I am on the activities page
    And I should be on the activities page

# @wip
#   Scenario: Sort by age tag
#     Given the following age tags exists:
#       | start_year | end_year |
#       |          1 |        5 |
#       |          6 |        8 |
#     Given the following activities exists:
#       | title      |
#       | Activity 1 |
#       | Activity 2 |
#     Given the following activity age relations exists:
#       | activity         | age tag      |
#       | title:Activity 1 | start_year:1 |
#       | title:Activity 1 | start_year:6 |
#       | title:Activity 2 | start_year:6 |
#     Then I go to the activities page
#     And I should see "Activity 1"
#     And I should see "Activity 2"


