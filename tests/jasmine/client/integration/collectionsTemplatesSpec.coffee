describe "Template listcollections", ->

    renderTemplate = (data) ->
        div = document.createElement "DIV"
        if data
            template = Blaze.renderWithData Template.listcollections, data, div
        else
            template = Blaze.render Template.listcollections, div
        return [div, template]

    xit "shows a list of collections", ->
        data = collections: Help.data.collections
        div = renderTemplate data
        console.log div
        expect($(div).find("tbody tr").length).toEqual 3

    xit "shows the Load More button if there are more collections", ->
        data = moreCollections: true
        div = document.createElement "DIV"
        Blaze.renderWithData Template.listcollections, data, div
        console.log "Data:", data, "Div:", div
        expect($(div).find("[name=\"more\"]").length).toEqual 3

    it "helper \"collections\" queries Collections.find", ->
        spyOn Collections, "find"
            .and.returnValue Help.data.collections
        result = Help.getHelper(Template.listcollections, "collections")()
        expect(result).toEqual Help.data.collections
        expect(Collections.find).toHaveBeenCalled()

    it "helper \"moreCollections\" returns true if there are more collections", ->
        spyOn Collections, "find"
            .and.returnValue count: -> 5
        spyOn Session, "get"
            .and.returnValue limit: 5
        result = Help.getHelper(Template.listcollections, "moreCollections")()
        expect(result).toEqual true
        expect(Collections.find).toHaveBeenCalled()
        expect(Session.get).toHaveBeenCalled()