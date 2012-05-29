Feature: Email dialog displaying
  In order to get notifications
  As a user
  I want to be able to set my email if it is still not available
  
  Scenario: Filter by direction tag
    Given I signed in as a user
    When I am on the home page
    Then I should not see "Введите свой эл. адрес:"
    
    Given current user field "email" is ""
    When I am on the home page
    Then I should see "Введите свой эл. адрес:"