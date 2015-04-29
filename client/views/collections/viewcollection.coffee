Template.viewcollection.helpers
    canEdit: ->
        canEdit Meteor.userId(), @
    mailtoLink: ->
        contactEmail = @contactEmail?.replace /\ /g, ""
        "mailto:#{contactEmail}?cc=collaboration_coordination@tissuehub.org&subject=Collaboration%20on%20#{@name}"
    managingOrganizationName: -> Organizations.findOne(_id: @managingOrganization).name
    selector: -> partOf: @_id

Template.viewcollection.events
    "click .delete": (e) ->
        e.preventDefault()
        if confirm "Delete this collection?"
            collectionId = @_id
            Collections.remove collectionId
            Router.go "listCollections"
