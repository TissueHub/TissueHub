Template.listcollections.helpers
    collections: ->
        filters = Session.get "collectionFilters"
        if filters
            Collections.find filters
        else
            Collections.find()

setFilters = (e) ->
    terms = $(e.target).val().split " "
    makefilter = (term) ->
        filter = $or: [
            { name: $regex: term, $options: "i" }
            { description: $regex: term, $options: "i" }
            { ethnicities: $regex: term, $options: "i" }
            { phenotypes: $regex: term, $options: "i" }
            { specimenTypes: $regex: term, $options: "i" }
        ]
    filters = $and: (makefilter term for term in terms when term)
    if filters.$and.length > 0
        Session.set "collectionFilters", filters
    else
        Session.set "collectionFilters", null

Template.listcollections.events
    "input [name=search]": setFilters

Template.listcollections.rendered = ->
    @$("[data-toggle='tooltip']").tooltip()
