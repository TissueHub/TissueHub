Template.editcollection.events
    "submit form": (e) ->
        e.preventDefault()
        collectionId = @_id
        collection =
            name: $(e.target).find("[name=name]").val()
            description: $(e.target).find("[name=description]").val()
            contactEmail: $(e.target).find("[name=contactEmail]").val()
            hostInstitution: $(e.target).find("[name=hostInstitution]").val()
            phenotypes: $(e.target).find("[name=phenotypes]").val().split(",")
            specimenTypes: $(e.target).find("[name=specimenTypes]").val().split(",")
            ethnicities: $(e.target).find("[name=ethnicities]").val().split(",")
            participantCount: $(e.target).find("[name=participantCount]").val()
        Collections.update collectionId, {$set: collection}, (error) ->
            if error then Alert.add error.message, "danger"
            else
                Alert.add "Collection Edited", "success"
                Router.go "viewCollection", _id: collectionId
