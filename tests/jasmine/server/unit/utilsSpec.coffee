describe "Utils helpers", ->

    describe "hasAttributes(object, attributes)", ->

        it "returns false if the object does not have all the attributes", ->
            object = first: "One", last: "Two"
            attributes = [ "first", "middle", "last"]
            expect(hasAttributes object, attributes).toBe false

        it "returns true if the object has all the attributes", ->
            object = first: "One", last: "Two", middle: "One and a Half"
            attributes = [ "first", "middle", "last"]
            expect(hasAttributes object, attributes).toBe true

    describe "getEmail(user)", ->

        testEmail = "fake@fake.com"

        it "returns undefined if user is falsey", ->
            expect(getEmail()).toBeUndefined()

        it "returns user.profile.email if present", ->
            expect(getEmail profile: email: testEmail).toBe testEmail

        it "returns user.emails[0].address if present", ->
            expect(getEmail emails: [ address: testEmail]).toBe testEmail

        it "returns user.services.google.email if present", ->
            expect(getEmail services: google: email: testEmail).toBe testEmail

        it "returns user.services.google.email if present", ->
            expect(getEmail services: google: email: testEmail).toBe testEmail