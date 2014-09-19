Template.listcollections.helpers
    collections: ->
        filter = Session.get "collectionFilter"
        if filter
            Collections.find filter
        else
            Collections.find()

Template.listcollections.events
    "keyup [name=search]": (e) ->
        value = $(e.target).val()
        filter = $or: [
            { name: $regex: value, $options: "i" }
            { description: $regex: value, $options: "i" }
            { ethnicities: $regex: value, $options: "i" }
            { phenotypes: $regex: value, $options: "i" }
            { specimenTypes: $regex: value, $options: "i" }
        ]
        Session.set "collectionFilter", filter
