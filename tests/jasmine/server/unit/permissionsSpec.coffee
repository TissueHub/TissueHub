describe "Permission helper", ->

    describe "ownsDocument(userId, doc)", ->

        it "returns false if doc is undefined", ->
            expect(ownsDocument()).toBe false

        it "returns false if doc.owner doesn't equal userId", ->
            expect(ownsDocument 5678, owner: 1234).toBe false

        it "returns true if doc.owner equals userId", ->
            expect(ownsDocument 1234, owner: 1234).toBe true

    describe "admin(userId)", ->

        it "checks if userId is in role admin with Roles.userIsInRole", ->
            spyOn Roles, "userIsInRole"
                .and.returnValue "Test"
            response = admin(1234)
            expect(Roles.userIsInRole).toHaveBeenCalledWith 1234, ["admin"]
            expect(response).toBe "Test"

    describe "curator(userId)", ->

        it "checks if userId is in role curator with Roles.userIsInRole", ->
            spyOn Roles, "userIsInRole"
                .and.returnValue "Test"
            response = curator(1234)
            expect(Roles.userIsInRole).toHaveBeenCalledWith 1234, ["curator"]
            expect(response).toBe "Test"

    describe "canEdit(userId, doc)", ->

        it "returns true if ownsDocument(userId, doc)", ->
            spyOn global, "ownsDocument"
                .and.returnValue true
            result = canEdit()
            expect(result).toBe true

        it "returns true if admin(userId)", ->
            spyOn global, "admin"
                .and.returnValue true
            result = canEdit()
            expect(result).toBe true

        it "returns true if curator(userId)", ->
            spyOn global, "curator"
                .and.returnValue true
            result = canEdit()
            expect(result).toBe true

        it "returns true if belongsToManagingOrganization(userId, doc)", ->
            spyOn global, "belongsToManagingOrganization"
                .and.returnValue true
            result = canEdit()
            expect(result).toBe true

        it "returns false otherwise", ->
            result = canEdit()
            expect(result).toBe false

    describe "ownsOrganization(userId, organization)", ->

        it "returns true if userId is in organization.owners", ->
            result = ownsOrganization "1234", owners: ["2345", "23562", "1234", "1642"]
            expect(result).toEqual true

        it "returns false if userId is not in organization.owners", ->
            result = ownsOrganization "1234", owners: ["2345", "23562", "123334", "1642"]
            expect(result).toEqual false

    describe "belongsToManagingOrganization", ->

        testParameters = (userId, collection, organization, expectedResult) ->
            spyOn Organizations, "findOne"
                .and.returnValue organization
            expect(belongsToManagingOrganization userId, collection).toEqual expectedResult
            expect(Organizations.findOne).toHaveBeenCalledWith "_id": collection.managingOrganization

        it "returns true if userId is a member of the managing organization", ->
            userId       = "abcdef"
            collection   = managingOrganization: "1234"
            organization = members: [userId]
            testParameters userId, collection, organization, true

        it "returns true if userId is an owner of the managing organization", ->
            userId       = "abcdef"
            collection   = managingOrganization: "1234"
            organization = owners: [userId]
            testParameters userId, collection, organization, true

        it "returns true if userId is a member of the managing organizations parent organization", ->
            userId       = "abcdef"
            collection   = managingOrganization: "1234"
            organization = members: ["notUserId"], memberOf: "0987"
            calls = 0
            spyOn Organizations, "findOne"
                .and.callFake ->
                    if calls > 0 then organization.members.push userId
                    calls++
                    organization
            spyOn global, "belongsToOrganization"
                .and.callThrough()
            expect(belongsToManagingOrganization userId, collection).toEqual true
            expect(Organizations.findOne).toHaveBeenCalledWith "_id": collection.managingOrganization
            expect(Organizations.findOne).toHaveBeenCalledWith "_id": organization.memberOf
            expect(belongsToOrganization.calls.count()).toEqual 2