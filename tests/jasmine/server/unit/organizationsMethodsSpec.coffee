describe "Organization Method \"createOrganization\"", ->

    it "require the Organizations collection", ->
        expect(Organizations).not.toBeUndefined()

    it "exists", ->
        expect(Meteor.methodMap.createOrganization).toBeDefined()

    it "returns a 401 if not logged in", ->
        spyOn Meteor, "user"
                .and.returnValue null
        Meteor.call "createOrganization", {}, (err, resp) ->
            expect(err.error).toBe 401
            expect(Meteor.user).toHaveBeenCalled()

    it "returns a 422 if missing organization name", ->
        spyOn Meteor, "user"
            .and.returnValue _id: 1234
        Meteor.call "createOrganization", {}, (err, resp) ->
            expect(err.error).toBe 422
            expect(Meteor.user).toHaveBeenCalled()

    describe " ", ->

        user = _id: 1234
        organization = 
            name: "MyTestOrganization"
        insertedOrganization = null

        beforeEach ->
            spyOn Meteor, "user"
                .and.returnValue user
            spyOn Organizations, "insert"

        beforeEach ->
            Meteor.call "createOrganization", organization
            insertedOrganization = Organizations.insert.calls.argsFor(0)[0]

        it "inserts the organization", ->
            expect(Organizations.insert).toHaveBeenCalled()

        it "adds owners = [user._id] to the inserted organization", ->
            expect(insertedOrganization.owners).toEqual [user._id]

        it "adds creator = user._id to the inserted organization", ->
            expect(insertedOrganization.creator).toEqual user._id

        it "adds dateCreated to the inserted organization", ->
            expect(insertedOrganization.dateCreated).toBeDefined()