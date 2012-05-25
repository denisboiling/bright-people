Feature: Post comments
  In order to add some feedback
  As a user
  I want to be able to post comments

@javascript
Scenario: Posting article comment
    Given a user visits article page
    And I follow "Добавить комментарий"
    And wait for ajax
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"

@javascript
Scenario: Posting interview comment
    Given a user visits interview page
    And I follow "Добавить комментарий"
    And wait for ajax
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"

@javascript
Scenario: Posting news comment
    Given a user visits news page
    And I follow "Добавить комментарий"
    And wait for ajax
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"

@javascript
Scenario: Posting special project comment
    Given a user visits special_project page
    And I follow "Добавить комментарий"
    And wait for ajax
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"
