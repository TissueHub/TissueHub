Jasmine.onTest ->
    describe "Organizations permissions", ->
        it "allows updates with a function", ->
            expect(Organizations._validators.update.allow[0]).toBe ownsOrganization