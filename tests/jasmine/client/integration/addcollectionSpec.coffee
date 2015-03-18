describe "Template addcollection", ->

    it "helper \"initialContactEmail\" wraps uses getEmail to get the current users email.", ->
        email = "a@b.com"
        spyOn window, "getEmail"
            .and.returnValue email
        result = Help.getHelper(Template.addcollection, "initialContactEmail")()
        expect(window.getEmail).toHaveBeenCalled()
        expect(result).toEqual email

    describe "handler \"submit form\"", ->

        e = null

        beforeEach ->
            e = preventDefault: jasmine.createSpy("preventDefault"), target: document.createElement("div")
            spyOn Meteor, "call"
            Help.callEventHandler Template.addcollection, "submit form", e

        it "prevents default event action", ->
            expect(e.preventDefault).toHaveBeenCalled()

        it "calls the \"collection\" method", ->
            expect(Meteor.call).toHaveBeenCalledWith "collection", jasmine.any(Object), jasmine.any(Function)

    describe "renders", ->

        renderTemplate = ->
            div = document.createElement "div"
            Blaze.render Template.addcollection, div
            return div

        it "a link back to the collection list", ->
            div = renderTemplate()
            expect($(div).find("a[href=\"/collections\"]").text()).toEqual "Cancel"