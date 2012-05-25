Feature: Create questions for specialist

Background:
  Given the following specialist exists:
  | name        |
  | Ivan Petrov |
  Given I am signin and login as "user" with "user@example.com/password"

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
  
  

