describe "Template listcollections", ->

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

    describe "renders", ->

        collectionsSpy = moreCollectionsSpy = div = null

        checkSpys = ->
            expect(collectionsSpy).toHaveBeenCalled()
            expect(moreCollectionsSpy).toHaveBeenCalled()

        beforeEach ->
            collectionsSpy = Help.spyOnHelper Template.listcollections, "collections", ->
                return Help.data.collections
            moreCollectionsSpy = Help.spyOnHelper Template.listcollections, "moreCollections", ->
                return true

        beforeEach ->
            div = document.createElement "div"
            Blaze.render Template.listcollections, div

        it "the \"Load More\" button if there are more collections", ->
            expect($(div).find("button[name=\"more\"]").length).toEqual 1
            checkSpys()

        it "the list of collections", ->
            expect($(div).find("tbody tr").length).toEqual 3