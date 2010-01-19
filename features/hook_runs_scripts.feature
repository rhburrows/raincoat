Feature: hooks runs all of the scripts in the hook's directory

  As a developer
  I want to run a series of scripts when git calls its hooks
  So that I can verify my code is in a good state at a given point

  Background:
  Given an existing hook

  Scenario: No scripts in the hook directory
    Given an empty hook directory
    When the hook is called
    Then the hook should exit with a 0 exit status

  Scenario: One failing script in the hook directory
    Given a hook directory with:
    | name  | result |
    | first |      1 |
    When the hook is called
    Then the hook should exit with a 1 exit status
