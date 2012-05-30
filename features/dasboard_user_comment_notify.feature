Feature: Describe user comments notify

  Background:
    Given I am signup and signin as "user" with "user@example.com/password"

  Scenario: Show comment notifies
    Given the following question exist:
      | text          |
      | Some question |
    And specialist answer for question "Some question"
    And I create comment for question "Some question" with "my answer"
    Then somebody commenting comment "my answer" with "somebody comment"
    Then I go to the dashboard notifications page
    And I should see "my answer"
    And I should see "somebody comment"

