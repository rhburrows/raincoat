Feature: user install hooks in a new git project

  As a developer
  I want to easily be able to add raincoat hooks into my Git project
  So that my scripts will run when I work with Git

  Background:
  Given I am in the temp directory
  And the directory is clean
  And a new git project

  Scenario Outline: Install hooks in script directory
    Given the ".git/hooks" directory is empty
    When I install the scripts in the script directory
    Then there should be a "<hook_name>" hook

  Examples:
    | hook_name   |
    | pre-commit  |
    | post-commit |
