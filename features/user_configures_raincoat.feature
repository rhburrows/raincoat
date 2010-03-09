Feature: user configures raincoat through YAML configuration file

  As a developer
  I want to be able to configure raincoat through a configuration file
  So that the configuration can be consistent across my team

  Background:
  Given I am in the temp directory
  And the directory is clean

  Scenario: Change the script directory
    When I write the configuration file:
      """
      script_dir: script/raincoat
      """
    And I create a "precommit" hook
    Then the hook should check for scripts in "script/raincoat/pre-commit"

  Scenario: Default configuration file is "raincoat.yml"
    When the "RAINCOAT_CONFIG" environment variable is not set
    Then the configuration should be read from "raincoat.yml"

  Scenario: Configuration file is from the RAINCOAT_CONFIG environment variable
    When the "RAINCOAT_CONFIG" environment variable is "file.yml"
    Then the configuration should be read from "file.yml"
    
