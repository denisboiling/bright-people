Feature: Create questions for specialist

  Background:
    Given the following specialist exists:
      | name        |
      | Ivan Petrov |
    Given I am signup and signin as "user" with "user@example.com/password"

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

# TODO: fix this scenario
# @wip
#   @javascript
#   Scenario: Create user sub comment for question
#     Given the following questions exists:
#       | specialist       | text          |
#       | name:Ivan Petrov | Cool question |
#       And specialist "Ivan Petrov" create answer for question "Cool question"
#       Then I go to the specialist question "Cool question" page
#       And I follow "Комментировать"
#       And I fill in "comment" with "This is my comment"
#       Then I press "Комментировать"
#       And I wait a second
#       And I should see "This is my comment"
#       And comment "This is my comment" should be child
