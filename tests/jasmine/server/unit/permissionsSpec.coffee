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