Feature: Fitler activities
  In order to get more specialized content that I need
  As a user
  I want to be able to use filter links
  
  Background:
    Given a direction tag exists with a name of "изучать"
    And age tag with 6 to 12 interval
    And activities with fields:
      | name           | direction_tag_names | age_tag_names          |
      | First Activity | ["творить"]         | ["1-3 лет", "3-6 лет"] |
      | Second One     | ["мастерить"]       | ["1-3 лет"]            |
    And I am on the activities page

  @javascript
  Scenario: Filter by direction tag
    When I follow "творить"
    And wait for ajax
    Then I should see "First Activity"
    And I should not see "Second One"
    
    When I follow "изучать"
    And wait for ajax
    Then I should not see "First Activity"
    And I should not see "Second One"
  
  @javascript
  Scenario: Filter by age tag and direction tag
    When I follow "1-3 лет"
    And wait for ajax
    Then I should see "First Activity"
    And I should see "Second One"
    
    When I follow "творить"
    And wait for ajax
    Then I should see "First Activity"
    And I should not see "Second One"
    
    When I follow "3-6 лет"
    And wait for ajax
    Then I should see "First Activity"
    And I should not see "Second One"
  
