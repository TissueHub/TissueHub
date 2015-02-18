module.exports = ->
    
    @Given /^I am on the home page$/, (next) =>
        @world.browser
            .url @world.cucumber.mirror.rootUrl
            .call next

    @When /^I navigate to "([^"]*)"$/, (relativePath, next) =>
        @world.browser
            .url @world.cucumber.mirror.rootUrl + relativePath
            .call next

    @When /^I click on the "([^"]*)" link$/, (linkText, next) =>
        selector = @world.xPathHelpers.linkXpath linkText
        @world.browser.click selector
            .call next