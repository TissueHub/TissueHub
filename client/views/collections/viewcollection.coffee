Template.viewcollection.helpers
    ownCollection: ->
        @owner == Meteor.userId()

Template.viewcollection.events
    "click .delete": (e) ->
        e.preventDefault()
        if confirm "Delete this collection?"
            collectionId = @_id
            Collections.remove collectionId
            Router.go "listCollections"
