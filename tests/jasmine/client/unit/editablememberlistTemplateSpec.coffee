describe "Template editablememberlist renders", ->

    div = organization = memberCount = null

    beforeEach ->
        user = Help.data.users["Isa Tufayl"]
        spyOn Meteor.users, "findOne"
            .and.returnValue user
        organization = Help.data.organizations[1]
        memberCount = organization.owners.length + organization.members.length
        div = Help.renderTemplate(Template.editablememberlist, organization) 

    it "a top level div.editable-member-list", ->
        expect($(div).find("div.editable-member-list").length).toEqual 1

    it "the header \"Members\"", ->
        expect($(div).find("h3").text()).toEqual "Members"

    it "a row for each member", ->
        expect($(div).find("div.member").length).toEqual memberCount

    it "a \"remove\" button for each member", ->
        expect($(div).find("div.member button.remove").length).toEqual memberCount

    it "an \"owner\" checkbox for each member", ->
        expect($(div).find("div.member input.owner").length).toEqual memberCount

    it "checks the \"owner\" checkbox for each owner", ->
        expect($(div).find("div.member input:checkbox:checked.owner").length).toEqual organization.owners.length

    it "an input for adding members", ->
        expect($(div).find("input[name=addusername]").length).toEqual 1

describe "Template editablememberlist helper \"allMembers\"", ->

    organization = result = user = null

    beforeEach ->
        spyOn Th, "getOrganizationMembers"
        organization = Help.data.organizations[1]
        allMembers = Help.getHelper(Template.editablememberlist, "allMembers").bind organization
        result = allMembers()

    it "wraps Th.getOrganizationMembers", ->
        expect(Th.getOrganizationMembers).toHaveBeenCalledWith organization

describe "Template editablememberlist handler \"rendered\"", ->

    beforeEach ->
        spyOn $.fn, "select2"
        Template.editablememberlist.rendered()

    it "sets up the input.addusername select2 box", ->
        expect($.fn.select2).toHaveBeenCalled()

describe "Template editablememberlist handler \"change [name=addusername]\"", ->

    e = div = form = organization = user = null

    beforeEach ->
        organization = Help.data.organizations[0]
        user = Help.data.users["Isa Tufayl"]
        spyOn Organizations, "update"
        spyOn Template, "parentData"
            .and.returnValue organization
        div = Help.renderTemplate(Template.editorganization)
        input = $("[name=addusername]", div).val(user._id)[0]
        e = preventDefault: jasmine.createSpy("preventDefault"), target: form
        Help.callEventHandler Template.editablememberlist, "change [name=addusername]", e

    it "prevents default event action", ->
        expect(e.preventDefault).toHaveBeenCalled()

    it "gets the organization id from Template.parentData(1)", ->
        expect(Template.parentData).toHaveBeenCalledWith 1

    it "adds the user by id to the organization", ->
        expect(Organizations.update).toHaveBeenCalledWith organization._id, $push: { members: user._id}