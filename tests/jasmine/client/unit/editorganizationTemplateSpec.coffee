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

    it "an editable list of the organization members (editablememberlist template)", ->
        #ensure we rendered the editablememberlist template
        expect($(div).find("div.editable-member-list").length).toEqual 1