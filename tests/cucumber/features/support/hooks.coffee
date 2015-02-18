module.exports = ->

    size =
        width: 1280
        height: 1024

    @Before =>
        next = arguments[arguments.length - 1]
        @world.xPathHelpers =
            linkXpath: (text) -> "//a[contains(text(),\"#{text}\")]"
            navXpath: (text) -> "//nav//a[contains(text(),\"#{text}\")]"
            linkTitleXpath: (text) -> "//a[@title='#{text}']"
            buttonXpath: (text) -> "//button[contains(text(),\"#{text}\")]"
            alertXpath: (text) -> "//div[contains(@class,\"alert\")][contains(text(),\"#{text}\")]"
            tdXpath: (text) -> "//td[contains(text(),\"#{text}\")]"
            h2Xpath: (text) -> "//h2[contains(text(),\"#{text}\")]"
        @world.browser.init()
            .setViewportSize(size)
            .call next


    @After =>
        next = arguments[arguments.length - 1]
        @world.browser.end().call next