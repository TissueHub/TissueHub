Template.listcollections.helpers
    collections: ->
        filters = Session.get "collectionFilters"
        if filters
            Collections.find filters
        else
            Collections.find()
    searchTerms: -> Session.get "searchTerms"

setFilters = (e, t) ->
    terms = $("[name=search]").val()
    makefilter = (term) ->
        filter = $or: [
            { hostInstitution: $regex: term, $options: "i" }
            { name: $regex: term, $options: "i" }
            { description: $regex: term, $options: "i" }
            { ethnicities: $regex: term, $options: "i" }
            { phenotypes: $regex: term, $options: "i" }
            { specimenTypes: $regex: term, $options: "i" }
        ]
    filters = $and: (makefilter term for term in terms.split " " when term)
    if filters.$and.length > 0
        Session.set "collectionFilters", filters
        window.history.pushState "listCollections", "TissueHub", Router.path "listCollections", null, query: "q=#{terms}"
    else
        Session.set "collectionFilters", null
        window.history.pushState "listCollections", "TissueHub", Router.path "listCollections"

Template.listcollections.events
    "input [name=search]": setFilters

Template.listcollections.rendered = ->
    @$("[data-toggle='tooltip']").tooltip()
    setFilters()
