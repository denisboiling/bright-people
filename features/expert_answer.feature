Feature: Expert answer
  
  Background:
    Given I signed in as a specialist

  Scenario: Path to specialist dashboard
    And I am on the home page
    Then I follow "Страница специалиста"
    And I should be on the specialist root page

  Scenario: First answer by question
    Given the following question exist:
      | specialist                   | text             |
      | email:specialist@example.com | This is question |
    Given the following question categories exists:
      | title      |
      | Category 1 |
      | Category 2 |
    Then I go to the specialist root page
    And I should see "This is question"
    And I follow "Ответить"
    And I should be on the specialist question "This is question" page
    Then I fill in "Ответ" with "This is answer"
    And I select "Category 2" from "Категория вопроса"
    Then I press "Ответить"
    And I should be on the specialist questions page
    And I should see "Ваш ответ сохранен"
    And question "This is question" should be publish
