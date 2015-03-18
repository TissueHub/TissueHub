describe "Template addcollection", ->

    it "helper \"initialContactEmail\" wraps uses getEmail to get the current users email.", ->
        email = "a@b.com"
        spyOn window, "getEmail"
            .and.returnValue email
        result = Help.getHelper(Template.addcollection, "initialContactEmail")()
        expect(window.getEmail).toHaveBeenCalled()
        expect(result).toEqual email

    describe "renders", ->

        renderTemplate = ->
            div = document.createElement "div"
            Blaze.render Template.addcollection, div
            return div

        it "a link back to the collection list", ->
            div = renderTemplate()
            expect($(div).find("a[href=\"/collections\"]").text()).toEqual "Cancel"