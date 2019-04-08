@mod @mod_assign @assignfeedback @assignfeedback_writeup
Feature: In an assignment, teachers can provide feedback writeup on student submissions
  In order to provide feedback to students on their assignments
  As a teacher,
  I need to create feedback writeup against their submissions.

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 0 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | teacher |
      | student1 | C1 | student |

  @javascript
  Scenario: Teachers should be able to add and remove feedback writeup via the quick grading interface
    Given the following "activities" exist:
      | activity | course | idnumber | name             | assignsubmission_onlinetext_enabled | assignfeedback_writeup_enabled |
      | assign   | C1     | assign1  | Test assignment1 | 1                                   | 1                               |
    And I log in as "student1"
    And I am on "Course 1" course homepage
    And I follow "Test assignment1"
    And I press "Add submission"
    And I set the following fields to these values:
      | Online text | I'm the student1 submission |
    And I press "Save changes"
    And I log out
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I follow "Test assignment1"
    And I navigate to "View all submissions" in current page administration
    Then I click on "Quick grading" "checkbox"
    And I set the field "Feedback writeup" to "Feedback from teacher."
    And I press "Save all quick grading changes"
    And I should see "The grade changes were saved"
    And I press "Continue"
    And I should see "Feedback from teacher."
    And I set the field "Feedback writeup" to ""
    And I press "Save all quick grading changes"
    And I should see "The grade changes were saved"
    And I press "Continue"
    And I should not see "Feedback from teacher."
