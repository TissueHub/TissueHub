describe "Template viewcollection", ->

    it "helper \"canEdit\" wraps canEdit with the current user and doc", ->
        spyOn Meteor, "userId"
        spyOn window, "canEdit"
            .and.returnValue value = {}
        result = Help.getHelper(Template.viewcollection, "canEdit")()
        expect(result).toEqual value
        expect(Meteor.userId).toHaveBeenCalled()
        expect(canEdit).toHaveBeenCalled()