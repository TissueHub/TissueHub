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
            { name: $regex: value }
            { description: $regex: value }
            { phenotypes: $regex: value }
            { specimentTypes: $regex: value }
        ]
        Session.set "collectionFilter", filter
