assert = require "assert"

module.exports = ->

    @Then /^I should see the title of "([^"]*)"$/, (expectedTitle, next) =>
        @world.browser.title (err, res) ->
            assert.equal res.value, expectedTitle
            next()