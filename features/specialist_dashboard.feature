Feature: Expert answer
  
  Background:
    Given I am signup and signin as "specialist" with "specialist@example.com/password"

  Scenario: Path to specialist dashboard
    And I am on the home page
    Then I follow "Страница специалиста"
    And I should be on the specialist user root page

  Scenario: First answer by question
    Given the following question exist:
      | specialist                   | text             |
      | email:specialist@example.com | This is question |
    Given the following question categories exists:
      | title      |
      | Category 1 |
      | Category 2 |
    Then I go to the specialist user root page
    And I should see "This is question"
    And I follow "Ответить"
    And I should be on the specialist user question "This is question" page
    Then I fill in "Ответ" with "This is answer"
    And I select "Category 2" from "Категория вопроса"
    Then I press "Ответить"
    And I should be on the specialist user questions page
    And I should see "Ваш ответ сохранен"
    And question "This is question" should be publish
