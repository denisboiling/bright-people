Feature: Fitler activities
  In order to get more specialized content that I need
  As a user
  I want to be able to use filter links
  
  @javascript
  Scenario: Filter by direction tag
    Given direction tag with name "творить"
    And direction tag with name "мастерить"
    And activities with fields:
      | name           | direction_tag_names |
      | First Activity | ["творить"]         |
      | Second One     | ["мастерить"]       |
    And I am on the activities page
    When I click on "творить" with ".activities_filter_link" selector
    And wait for a while
    Then I should see "First Activity"
    And I should not see "Second One"