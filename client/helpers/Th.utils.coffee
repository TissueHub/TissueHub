Th = window.Th = {}

Th.makeFiltersFromTerms = (terms) ->
    makefilter = (term) ->
        filter = $or: [
            { hostInstitution: $regex: term, $options: "i" }
            { name: $regex: term, $options: "i" }
            { description: $regex: term, $options: "i" }
            { ethnicities: $regex: term, $options: "i" }
            { phenotypes: $regex: term, $options: "i" }
            { specimenTypes: $regex: term, $options: "i" }
        ]
    filters = $and: (makefilter term for term in terms.split "," when term)
    filters

# xPath Evaluators. Mostly useful for debugging.
linkXpath = (text) -> "//a[contains(text(),\"#{text}\")]"
navXpath = (text) -> "//nav//a[contains(text(),\"#{text}\")]"
linkTitleXpath = (text) -> "//a[@title='#{text}']"
buttonXpath = (text) -> "//button[contains(text(),\"#{text}\")]"
alertXpath = (text) -> "//div[contains(@class,\"alert\")][contains(text(),\"#{text}\")]"
tdXpath = (text) -> "//td[contains(text(),\"#{text}\")]"
h2Xpath = (text) -> "//h2[contains(text(),\"#{text}\")]"

Th.evaluateXPath = (node, expression) ->
        xpe = new XPathEvaluator()
        nsResolver = xpe.createNSResolver(if node.ownerDocument == null then node.documentElement else node.ownerDocument.documentElement)
        result = xpe.evaluate(expression, node, nsResolver, 0, null)
        found = []
        while res = result.iterateNext()
            found.push res
        return found
Th.exp = (expression) -> Th.evaluateXPath(document, expression)
Th.xp =
    link: (text) -> Th.exp linkXpath text
    nav: (text) -> Th.exp navXpath text
