describe "Collections Method \"collection\"", ->

    it "exists", ->
        expect(Meteor.methodMap.collection).toBeDefined()

    it "returns a 401 if not logged in", ->
        spyOn Meteor, "user"
                .and.returnValue null
        Meteor.call "collection", {}, (err, resp) ->
            expect(err.error).toBe 401
            expect(Meteor.user).toHaveBeenCalled()

    it "returns a 422 if missing collection name", ->
        spyOn Meteor, "user"
            .and.returnValue _id: 1234
        Meteor.call "collection", {}, (err, resp) ->
            expect(err.error).toBe 422
            expect(Meteor.user).toHaveBeenCalled()

    it "inserts collection with added owner, creator, and dateCreated fields", ->
        spyOn Meteor, "user"
            .and.returnValue _id: 1234
        spyOn Collections, "insert"
        Meteor.call "collection", {name: "MyTestCollection"}, (err, resp) ->
            expect(err).toBeNull()
            expect(Meteor.user).toHaveBeenCalled()
            expect(Collections.insert.calls.argsFor(0)[0]).toHaveAttributes {name: "MyTestCollection", owner: 1234, creator: 1234}