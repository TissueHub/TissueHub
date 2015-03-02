Feature: Adding a collection

    As an user
    I want to be able to add a collection
    So that I can publish my collection to others

    Scenario: You must be logged in to add a collection.
        Given I am on the home page
        And I am logged out
        When I navigate to "collections/new"
        And I click on the "Save Collection" button
        Then I should see an alert "You must be logged in to create collections"
