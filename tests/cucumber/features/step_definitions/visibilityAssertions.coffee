module.exports = ->

    assert = require "assert"

    @Then /^I should see the link "([^"]*)"$/, (linkText, next) =>
        selector = @world.xPathHelpers.linkXpath linkText
        @world.browser.isVisible selector, (err, isVisible) ->
            assert isVisible, "Expected link #{linkText} to be visible."
            next()

    @Then /^I should see the nav "([^"]*)"$/, (navText, next) =>
        selector = @world.xPathHelpers.navXpath navText
        @world.browser.isVisible selector, (err, isVisible) ->
            assert isVisible, "Expected nav #{navText} to be visible."
            next()

    @Then /^I should see an alert "([^"]*)"$/, (alertText, next) =>
        selector = @world.xPathHelpers.alertXpath alertText
        @world.browser.isVisible selector, (err, isVisible) ->
            assert isVisible, "Expected alert \"#{alertText}\" to be visible."
            next()