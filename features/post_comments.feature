Feature: Post comments
  In order to add some feedback
  As a user
  I want to be able to post comments

@javascript
Scenario: Posting article comment
    Given the following article category exists:
      | title        |
      | testcategory |
    Given the following article exists:
      | title     | author   | content              | article_category_id |
      | testtitle | tauthort | qweqweqwe12dsadzxczx | id: testcategory    |
    And I am on the article "testtitle" page
    And I follow "Добавить комментарий"
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"

@javascript
Scenario: Posting interview comment
    Given the following interview exists:
      | title         | author   | content              |
      | testinterview | tauthort | qweqweqwe12dsadzxczx |
    And I am on the interview "testinterview" page
    And I follow "Добавить комментарий"
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"

@javascript
Scenario: Posting news comment
    Given the following news exists:
      | title    | author   | content              |
      | testnews | tauthort | qweqweqwe12dsadzxczx |
    And I am on the news "testnews" page
    And I follow "Добавить комментарий"
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"

@javascript
Scenario: Posting special project comment
    Given the following special project exists:
      | title       | author   | content              |
      | testproject | tauthort | qweqweqwe12dsadzxczx |
    And I am on the special_project "testproject" page
    And I follow "Добавить комментарий"
    And I fill in "comment_content" with "Test comment"
    When I follow "Отправить"
    And wait for ajax
    Then I should see "Test comment"
