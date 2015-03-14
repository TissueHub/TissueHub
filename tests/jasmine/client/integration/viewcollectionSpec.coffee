describe "Template viewcollection", ->

    it "helper \"canEdit\" wraps canEdit with the current user and doc", ->
        spyOn Meteor, "userId"
        spyOn window, "canEdit"
            .and.returnValue value = {}
        result = Help.getHelper(Template.viewcollection, "canEdit")()
        expect(result).toEqual value
        expect(Meteor.userId).toHaveBeenCalled()
        expect(canEdit).toHaveBeenCalled()

    describe "helper \"mailtoLink\"", ->

        result = null
        data = contactEmail: "test@example.com", name: "Test Collection"

        beforeEach ->
            mailtoLink = Help.getHelper(Template.viewcollection, "mailtoLink").bind data
            result = mailtoLink()

        it "builds the mailto link to contactEmail", ->
            expect(result).toMatch "mailto:#{data.contactEmail}"

        it "includes a cc to the collaboration coordinator", ->
            expect(result).toMatch "cc=collaboration_coordination@tissuehub.org"

        it "includes a subject mentioning the collection name", ->
            expect(result).toMatch "subject=Collaboration%20on%20#{data.name}"

    describe "renders", ->

        data = Help.data.collections[0] # A test collection

        renderTemplate = ->
            div = document.createElement "div"
            Blaze.renderWithData Template.viewcollection, data, div
            return div

        it "a link back to the collection list", ->
            div = renderTemplate()
            expect($(div).find("a[href=\"/collections\"]").text()).toEqual "Back to Collection List"

        it "the \"edit\" and \"delete\" buttons if canEdit is true", ->
            canEditSpy = Help.spyOnHelper Template.viewcollection, "canEdit", -> true
            div = renderTemplate()
            expect($(div).find("a.edit").text()).toEqual " Edit"
            expect($(div).find("a.delete").text()).toEqual " Delete"

        it "no \"edit\" and \"delete\" buttons if canEdit is false", ->
            canEditSpy = Help.spyOnHelper Template.viewcollection, "canEdit", -> false
            div = renderTemplate()
            expect($(div).find("a.edit").length).toEqual 0
            expect($(div).find("a.delete").length).toEqual 0