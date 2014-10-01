Template.viewcollection.helpers
    ownCollection: ->
        @owner == Meteor.userId()
    mailtoLink: ->
        "mailto:#{@contactEmail}?cc=collaboration_coordination@tissuehub.org&subject=Collaboration%20on%20#{@name}"

Template.viewcollection.events
    "click .delete": (e) ->
        e.preventDefault()
        if confirm "Delete this collection?"
            collectionId = @_id
            Collections.remove collectionId
            Router.go "listCollections"
