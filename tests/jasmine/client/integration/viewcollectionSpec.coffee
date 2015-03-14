describe "Template viewcollection", ->

    it "helper \"canEdit\" wraps canEdit with the current user and doc", ->
        spyOn Meteor, "userId"
        spyOn window, "canEdit"
            .and.returnValue value = {}
        result = Help.getHelper(Template.viewcollection, "canEdit")()
        expect(result).toEqual value
        expect(Meteor.userId).toHaveBeenCalled()
        expect(canEdit).toHaveBeenCalled()

    it "helper \"mailtoLink\" builds the mailto link, including subject and cc to collaboration coordination"

    describe "renders", ->

        it "a link back to the collection list"

        it "the \"edit\" and \"delete\" buttons for the collection owner"

        it "the \"edit\" and \"delete\" buttons for administrators"

        it "the \"edit\" and \"delete\" buttons for curators"

        it "no \"edit\" and \"delete\" buttons for other users"