assert = require "assert"

module.exports = ->

    @Given /^I am logged out$/, (next) =>
        @world.browser
            .executeAsync (done) -> Meteor.logout(done)
            .call next

    @Given /^User "([^"]*)" does not exist$/, Meteor.wrapAsync (userID, next) =>
        connection = DDP.connect @world.cucumber.mirror.host
        connection.call "/fixtures/removeTestUser", Data[userID].email, (err, res) ->
            if err then next.fail(err)
            next()

    @When /^Enter and submit "([^"]*)" details$/, (userID, next) =>
        @world.browser
            .setValue "input#login-email", Data[userID].email
            .setValue "input#login-password", Data[userID].password
            .click "#login-buttons-password"
            .call next

    @Then /^I should be logged in as "([^"]*)"$/, (userID, next) =>
        @world.browser
            .saveScreenshot "#{@world.screenshotPath}/login.png" # Required to make it pass. Some kind of race condition?
            .executeAsync ((done) -> done Meteor.user()), (err, res) ->
                email = res.value?.emails?[0].address
                assert.equal email, Data[userID].email
            .call next


Data =
    "New User 1":
        email: "newuser1@example.com"
        password: "password"