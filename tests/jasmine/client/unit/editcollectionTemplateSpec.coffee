describe "Template editcollection renders", ->

    div = collection = null

    beforeEach ->
        user = Help.data.users["Isa Tufayl"]
        spyOn Meteor.users, "findOne"
            .and.returnValue user
        collection = Help.data.collections[1]
        div = Help.renderTemplate(Template.editcollection, collection)

    it "an input for the collection's name", ->
        expect($(div).find("input[name=\"name\"]").val()).toEqual collection.name

    it "an input for the collection's contactEmail", ->
        expect($(div).find("input[name=\"contactEmail\"]").val()).toEqual collection.contactEmail

    it "an input for the collection's hostInstitution", ->
        expect($(div).find("input[name=\"hostInstitution\"]").val()).toEqual collection.hostInstitution

    it "an input for the collection's particpantCount", ->
        expect($(div).find("input[name=\"particpantCount\"]").val()).toEqual collection.particpantCount

    it "an input for the collection's managingOrganization", ->
        expect($(div).find("input[name=\"managingOrganization\"]").val()).toEqual collection.managingOrganization || ""

    it "an input for the collection's description", ->
        expect($(div).find("textarea[name=\"description\"]").val()).toEqual collection.description

    it "an input for the collection's notes", ->
        expect($(div).find("textarea[name=\"notes\"]").val()).toEqual collection.notes || ""

    it "an input for the collection's phenotypes", ->
        expect($(div).find("input[name=\"phenotypes\"]").val()).toEqual collection.phenotypes.join ","

    it "an input for the collection's specimenTypes", ->
        expect($(div).find("input[name=\"specimenTypes\"]").val()).toEqual collection.specimenTypes.join ","

    it "an input for the collection's ethnicities", ->
        expect($(div).find("input[name=\"ethnicities\"]").val()).toEqual collection.ethnicities.join ","


describe "Template editcollection handler \"submit form\"", ->

    e = div = form = collection = editedCollection = null

    beforeEach ->
        spyOn Collections, "update"
        collection = Help.data.collections[0]
        div = Help.renderTemplate(Template.editcollection, collection)
        editedCollection = _.clone collection
        editedCollection.description += " and Waffles"
        form = Th.fillForm $("form", div), editedCollection
        e = preventDefault: jasmine.createSpy("preventDefault"), target: form
        Help.callEventHandler Template.editcollection, "submit form", e, collection

    it "prevents default event action", ->
        expect(e.preventDefault).toHaveBeenCalled()

    it "updates the collection as appropriate", ->
        expect(Collections.update).toHaveBeenCalledWith collection._id, {$set: _.pick(editedCollection, "name", "description", "contactEmail", "hostInstitution", "phenotypes", "specimenTypes", "ethnicities", "participantCount", "notes", "managingOrganization")}, jasmine.any(Function)


fdescribe "Template editcollection handler \"rendered\"", ->

    beforeEach ->
        spyOn $.fn, "select2"
        Template.editcollection.rendered()

    it "sets up the input.managingOrganization select2 box", ->
        expect($.fn.select2).toHaveBeenCalled()

    it "initializes the value of the input.managingOrganization box", ->
        org = _id: "a1s2d3f4", name: "My Organization"
        spyOn Organizations, "findOne"
            .and.returnValue org
        Template.editcollection.rendered.bind(data: managingOrganization: org._id)()
        expect(Organizations.findOne).toHaveBeenCalledWith _id: org._id
        expect($.fn.select2).toHaveBeenCalledWith "data", {id: org._id, text: org.name}