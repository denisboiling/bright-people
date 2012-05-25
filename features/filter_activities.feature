Feature: Fitler activities
  In order to get more specialized content that I need
  As a user
  I want to be able to use filter links
  
  Background:
    Given activities with fields:
      | name           | direction_tag_names | year_tag_intervals |
      | First Activity | ["творить"]         | [[1, 3], [5,6]]    |
      | Second One     | ["мастерить"]       | [[1 ,3]]           |
    And I am on the activities page
  
  @javascript
  Scenario: Filter by direction tag
    When I click on "творить" with ".activities_filter_link" selector
    And wait for ajax
    Then I should see "First Activity"
    And I should not see "Second One"

  