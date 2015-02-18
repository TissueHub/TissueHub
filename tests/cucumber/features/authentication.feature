Feature: Signing up, in, and out

    As a user
    I want to be able to sign up, in, and out
    So that I can acccess all my TissueHub features

    Scenario: Signing up as a new user.
        Given I am on the home page
        And I am logged out
        And User "New User 1" does not exist
        When I click on the "Sign in" link
        And I click on the "Create account" link
        And Enter and submit "New User 1" details
        Then I should be logged in as "New User 1"

    Scenario: Signing in
        Given I am on the home page
        And I am logged out
        And User "New User 1" exists
        When I click on the "Sign in" link
        And Enter and submit "New User 1" details
        Then I should be logged in as "New User 1"

    Scenario: Signing out
        Given I am on the home page
        And I am logged in as "Isa Tufayl"
        When I click on the Authentication Menu
        When I click on the "Sign out" button
        Then I should be logged out