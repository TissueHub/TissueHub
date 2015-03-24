beforeEach ->
    jasmine.addMatchers
        toHaveAttributes: ->
            compare: (actual, expected) ->
                passed = _.every expected, (value, key) ->
                    return actual[key] == expected[key]
                if passed then return pass: true
                else return pass: false, message: "Expected #{JSON.stringify(actual)} to contain the attributes #{JSON.stringify(expected)}"