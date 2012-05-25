Feature: Create questions for specialist

  Background:
    Given a specialist exists with a name of "Ivan Petrov"
    And I signed in as a specialist
  
  Scenario: Show path to specialists page
    And I am on the specialists page
    And I should see "Ivan Petrov"
  
  @javascript
  Scenario: Create question for specialist
    And I am on the specialists page
    Then I follow "Ivan Petrov"
    And I should be on the specialist "Ivan Petrov" page
    And I follow "Задать свой вопрос"
    And I fill in "question_text" with "This is qustion"
    Then I press "Отправить"
    Then I should be on the specialist "Ivan Petrov" page
    And I should see "Ваш вопрос оптавлен специалисту"
  
  Scenario: Show only publish questions
    Given the following questions exists:
      | specialist       | text             | publish |
      | name:Ivan Petrov | Publish question | true    |
      | name:Ivan Petrov | Not publish      | false   |
    Then I go to the specialist "Ivan Petrov" page
    And I should see "Publish question"
    And I should not see "Not publish"
