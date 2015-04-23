describe "Template editorganization renders", ->

    div = organization = null

    beforeEach ->
        user = Help.data.users["Isa Tufayl"]
        spyOn Meteor.users, "findOne"
            .and.returnValue user
        organization = Help.data.organizations[1]
        div = Help.renderTemplate(Template.editorganization, organization) 

    it "an input for the organization's name", ->
        expect($(div).find("input[name=\"name\"]").val()).toEqual organization.name

    it "an input for the organization's description", ->
        expect($(div).find("textarea[name=\"description\"]").val()).toEqual organization.description

    it "an input for the organization's url", ->
        expect($(div).find("input[name=\"url\"]").val()).toEqual organization.url

    it "an input for the organization's memberOf", ->
        expect($(div).find("input[name=\"memberOf\"]").val()).toEqual organization.memberOf

    it "an editable list of the organization members (editablememberlist template)", ->
        #ensure we rendered the editablememberlist template
        expect($(div).find("div.editable-member-list").length).toEqual 1

describe "Template editorganization handler \"submit form\"", ->

    e = div = form = organization = editedOrganization = null

    beforeEach ->
        spyOn Organizations, "update"
        organization = Help.data.organizations[0]
        div = Help.renderTemplate(Template.editorganization, organization)
        editedOrganization = _.clone organization
        editedOrganization.description += " and Waffles"
        form = Th.fillForm $("form", div), editedOrganization
        e = preventDefault: jasmine.createSpy("preventDefault"), target: form
        Help.callEventHandler Template.editorganization, "submit form", e, organization

    it "prevents default event action", ->
        expect(e.preventDefault).toHaveBeenCalled()

    it "updates the organization as appropriate", ->
        expect(Organizations.update).toHaveBeenCalledWith organization._id, {$set: _.pick(editedOrganization, "name", "description", "url", "memberOf")}, jasmine.any(Function)

describe "Template editorganization handler \"rendered\"", ->

    beforeEach ->
        spyOn $.fn, "select2"
        Template.editorganization.rendered()

    it "sets up the input.managingOrganization select2 box", ->
        expect($.fn.select2).toHaveBeenCalled()

    it "initializes the value of the input.managingOrganization box", ->
        org = _id: "a1s2d3f4", name: "My Organization"
        spyOn Organizations, "findOne"
            .and.returnValue org
        Template.editorganization.rendered.bind(data: memberOf: org._id)()
        expect(Organizations.findOne).toHaveBeenCalledWith _id: org._id
        expect($.fn.select2).toHaveBeenCalledWith "data", {id: org._id, text: org.name}