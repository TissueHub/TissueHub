describe "Template addorganization renders", ->

    it "a link back to the organization list", ->
        div = Help.renderTemplate(Template.addorganization)
        expect($(div).find("a[href=\"/organizations\"]").text()).toEqual "Cancel"

describe "Template addorganization handler 'submit form'", ->

    e = div = form = organization = null

    beforeEach ->
        spyOn Meteor, "call"
        organization = Help.data.organizations[0]
        div = Help.renderTemplate(Template.addorganization)
        form = Th.fillForm $("form", div), organization
        e = preventDefault: jasmine.createSpy("preventDefault"), target: form
        Help.callEventHandler Template.addorganization, "submit form", e

    it "prevents default event action", ->
        expect(e.preventDefault).toHaveBeenCalled()

    it "calls the \"createOrganization\" method", ->
        expect(Meteor.call).toHaveBeenCalledWith "createOrganization", _.pick(organization, "name", "description", "url"), jasmine.any(Function)