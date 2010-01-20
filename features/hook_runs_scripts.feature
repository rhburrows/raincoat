Feature: hooks runs all of the scripts in the hook's directory

  As a developer
  I want to run a series of scripts when git calls its hooks
  So that I can verify my code is in a good state at a given point

  Background:
  Given a clean script directory
  And an existing hook

  Scenario: No scripts in the hook directory
    Given an empty hook directory
    When the hook is called
    Then the hook should exit with a 0 exit status

  Scenario: One failing script in the hook directory
    Given a hook directory with:
    | name         | result |
    | first_script | false  |
    When the hook is called
    Then the hook should exit with a 1 exit status

  Scenario: One passing script in the hook directory
    Given a hook directory with:
    | name         | result |
    | first_script | true   |
    When the hook is called
    Then the hook should exit with a 0 exit status

  Scenario: Multiple scripts one failing
    Given a hook directory with:
    | name          | result |
    | first_script  | true   |
    | second_script | false  |
    | third_script  | true   |
    When the hook is called
    Then the hook should exit with a 1 exit status

  Scenario: Multiple scripts all passing
    Given a hook directory with:
    | name          | result |
    | first_script  | true   |
    | second_script | true   |
    | third_script  | true   |
    When the hook is called
    Then the hook should exit with a 0 exit status

  Scenario: Multiple failures all failing
    Given a hook directory with:
    | name          | result |
    | first_script  | false  |
    | second_script | false  |
    | third_script  | false  |
    When the hook is called
    Then the hook should exit with a 1 exit status
