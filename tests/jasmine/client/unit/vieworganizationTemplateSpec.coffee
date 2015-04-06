describe "Template vieworganization renders", ->

    div = organization = null

    beforeEach ->
        user = Help.data.users["Isa Tufayl"]
        spyOn Meteor.users, "findOne"
            .and.returnValue user
        organization = Help.data.organizations[1]
        div = Help.renderTemplate(Template.vieworganization, organization)

    it "a link back to the organization list", ->
        expect($(div).find("a[href=\"/organizations\"]").text()).toEqual "Back to Organization List"

    it "the name of the organization", ->
        expect($(div).find("h2").text()).toEqual "#{organization.name} #{organization.url}"

    it "the description of the organization", ->
        expect($(div).find("p.lead").text()).toEqual organization.description

    it "the url of the organization", ->
        expect($(div).find("h2 small a").text()).toEqual organization.url

    it "a list of members (including owners)", ->
        expect($(div).find("ul.members li").length).toEqual organization.owners.length + organization.members.length

    it "an \"owner\" badge for each owner in the member list", ->
        expect($(div).find("ul.members li span.label-info").length).toEqual organization.owners.length


describe "Template vieworganization helper \"allMembers\"", ->

    organization = result = user = null

    beforeEach ->
        user = Help.data.users["Isa Tufayl"]
        spyOn Meteor.users, "findOne"
            .and.returnValue user
        organization = Help.data.organizations[1]
        allMembers = Help.getHelper(Template.vieworganization, "allMembers").bind organization
        result = allMembers()

    it "includes all organization owners and members", ->
        expect(result.length).toEqual organization.owners.length + organization.members.length

    it "includes the owner:true property on owners", ->
        owners = result.filter (member) -> member.owner
        expect(owners.length).toEqual organization.owners.length

    it "looks up each user", ->
        expect(Meteor.users.findOne).toHaveBeenCalled()

    it "annotates each user with their username", ->
        expect(result[0].username).toEqual user.username

    it "does not throw if there are no members", ->
        organization = name: "Hello", owners: ["1234"]
        allMembers = Help.getHelper(Template.vieworganization, "allMembers").bind organization
        expect(allMembers).not.toThrow()

describe "Template vieworganization helper \"ownsOrganization\"", ->

    it "wraps the current organization and user", ->
        spyOn Meteor, "userId"
        spyOn window, "ownsOrganization"
            .and.returnValue value = {}
        result = Help.getHelper(Template.vieworganization, "ownsOrganization")()
        expect(result).toEqual value
        expect(Meteor.userId).toHaveBeenCalled()
        expect(ownsOrganization).toHaveBeenCalled()