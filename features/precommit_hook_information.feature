Feature: Precommit script are passed useful information from the hook

  In order to make writing precommit scripts simpler
  As a developer
  I want the Precommit hook to pass information about the state of the commit
  to my script

  Background:
  Given I am in the temp directory
  And the directory is clean
  And a new git project

  Scenario: List of changed files
    Given I have staged changes in files:
    | name  |
    | a.txt |
    | b.txt |
    | c.txt |
    And an existing "precommit" hook
    When the hook is called
    Then the list of changed files should include "a.txt"
    And the list of changed files should include "b.txt"
    And the list of changed files should include "c.txt"

  Scenario: Raw diff
    Given I have one new empty file called "touch" staged
    And an existing "precommit" hook
    When the hook is called
    Then the raw changes should be:
    """
diff --git a/touch b/touch
new file mode 100644
index 0000000..e69de29
    """
