Feature: Rake tasks for raincoat

  As a developer
  I want to trigger my raincoat scripts through a rake task
  So that I don't have to call git to run the scripts

  Background:
  Given I am in the temp directory
  And the directory is clean

  Scenario: Requiring the raincoat tasks file creates the task
    Given I have a Rakefile that requires the raincoat tasks
    When I run "rake -T"
    Then it should list the tasks:
    | name                |
    | raincoat:precommit  |
    | raincoat:postcommit |

  # Need to find a way to better test the entire rake tasks?
