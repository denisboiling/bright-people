Feature: Post comments

# TODO: create test for not sign user
# TODO: create test for contest
  Background:
    Given I am signup and signin as "user" with "user@example.com/password"

  @javascript
  Scenario: Create top level comment for question
    Given the following specialist exists:
      | name        |
      | Ivan Petrov |
    Given the following questions exists:
      | specialist       | text          |
      | name:Ivan Petrov | Cool question |
    And specialist "Ivan Petrov" create answer for question "Cool question"
    Then I go to the specialist question "Cool question" page
    And I fill in "comment" with "This is my comment"
    Then I press "Комментировать"
    And I wait a second
    And I should see "This is my comment"

  @javascript
  Scenario: Posting article top level comment
    Given the following article exist:
      | title        |
      | Cool article |
    Then I go to the article "Cool article" page
    And I fill in "comment" with "This is my comment"
    Then I press "Комментировать"
    And I wait a second
    And I should see "This is my comment"
    Then I go to the article "Cool article" page
    And I should see "This is my comment"

  @javascript
  Scenario: Posting interview top level comment
    Given the following interview exist:
      | title          |
      | Cool interview |
    Then I go to the interview "Cool interview" page
    And I fill in "comment" with "This is my comment"
    Then I press "Комментировать"
    And I wait a second
    And I should see "This is my comment"
    Then I go to the interview "Cool interview" page
    And I should see "This is my comment"

  @javascript
  Scenario: Posting news top level comment
    Given the following news exist:
      | title     |
      | Cool news |
    Then I go to the news "Cool news" page
    And I fill in "comment" with "This is my comment"
    Then I press "Комментировать"
    And I wait a second
    And I should see "This is my comment"
    Then I go to the news "Cool news" page
    And I should see "This is my comment"

  @javascript
  Scenario: Posting special project top level comment
    Given the following special project exist:
      | title        |
      | Cool project |
    Then I go to the special project "Cool project" page
    And I fill in "comment" with "This is my comment"
    Then I press "Комментировать"
    And I wait a second
    And I should see "This is my comment"
    Then I go to the special project "Cool project" page
    And I should see "This is my comment"
    
