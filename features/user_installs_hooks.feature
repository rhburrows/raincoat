Feature: user install hooks in a new git project

  As a developer
  I want to easily be able to add raincoat hooks into my Git project
  So that my scripts will run when I work with Git

  Background:
  Given a clean project directory
  And a new git project

  Scenario Outline: Install hooks in script directory
    Given I am in the project directory
    When I install the scripts in the script directory
    Then there should be a "<hook_name>" hook
    And there should be a "<hook_name>" script directory

  Examples:
    | hook_name  |
    | pre-commit |
    
