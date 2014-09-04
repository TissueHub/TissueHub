Template.addcollection.events
    "submit form": (e) ->
        e.preventDefault()
        collection =
            name: $(e.target).find("[name=name]").val()
            description: $(e.target).find("[name=description]").val()
            phenotypes: $(e.target).find("[name=phenotypes]").val().split(",")
            specimenTypes: $(e.target).find("[name=specimenTypes]").val().split(",")
            participantCount: $(e.target).find("[name=participantCount]").val()
        Meteor.call "collection", collection, (error, id) ->
            if error then Alert.add error.message, "danger"
            else
                Alert.add "Successfully added collection.", "success"
                Router.go "listCollections"
