Feature: Create questions for specialist

Background:
  Given the following specialist exists:
  | first_name | last_name |
  | Ivan       | Petrov    |
  Given I am signin and login as "user" with "user@example.com/password"

Scenario: Show path to specialists page
  And I am on the specialists page
  And I should see "Ivan Petrov"
@wip
Scenario: Create question for specialist
  And I am on the specialist "Ivan" page
  

