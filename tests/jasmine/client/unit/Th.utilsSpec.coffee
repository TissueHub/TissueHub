describe "Client utility helper Th", ->

    describe "fillForm", ->

        data = { firstname: "David", lastname: "Robbins", notPresent: "No Error" }
        formHTML = "<form>
                <input name=\"firstname\" />
                <input name=\"lastname\" />
            </form>"
        form = result = null

        beforeEach ->
            form = $.parseHTML(formHTML)[0]
            result = Th.fillForm form, data

        it "exists", ->
            expect(Th.fillForm).toEqual jasmine.any(Function)

        it "puts each field in data in the appropriate named form field", ->
            expect($("[name=firstname]", form).val()).toEqual data.firstname
            expect($("[name=lastname]", form).val()).toEqual data.lastname

        it "returns the form", ->
            expect(result).toEqual form

    describe "getOrganizationMembers(organization)", ->

        organization = result = user = null

        beforeEach ->
            user = Help.data.users["Isa Tufayl"]
            spyOn Meteor.users, "findOne"
                .and.returnValue user
            organization = Help.data.organizations[1]
            result = Th.getOrganizationMembers organization

        it "includes all organization owners and members", ->
            expect(result.length).toEqual organization.owners.length + organization.members.length

        it "includes the owner:true property on owners", ->
            owners = result.filter (member) -> member.owner
            expect(owners.length).toEqual organization.owners.length

        it "looks up each user", ->
            expect(Meteor.users.findOne).toHaveBeenCalled()
            expect(Meteor.users.findOne.calls.count()).toEqual result.length

        it "annotates each user with their username", ->
            expect(result[0].username).toEqual user.username

        it "does not throw if there are no members", ->
            organization = name: "Hello", owners: ["1234"]
            allMembers = -> Th.getOrganizationMembers organization
            expect(allMembers).not.toThrow()