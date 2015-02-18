Feature: TissueHub Homepage

    As a user of TissueHub
    I want an informative homepage
    So that I can easily figure out what TissueHub is, who made it, and what I can do with it.

    Scenario: The TissueHub title is displayed.
        Given I am on the home page
        When I navigate to "/"
        Then I should see the title of "TissueHub"

    Scenario: A "View Collections" call to action is visible
        Given I am on the home page
        When I navigate to "/"
        Then I should see the link "View Collections"

    Scenario: A Nav link to Collections is visible
        Given I am on the home page
        When I navigate to "/"
        Then I should see the nav "Collections"