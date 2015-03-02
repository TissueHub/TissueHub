Feature: Administrating TissueHub

    As an admin
    I want to be able to access administrative features
    So that I can administrate TissueHub

    Scenario: Administrators can access the Admin Tab
        Given I am on the home page
        And I am logged in as "Admin"
        Then I should see the nav "Admin"
