Template.addcollection.helpers
    initialContactEmail: -> getEmail Meteor.user()

Template.addcollection.events
    "submit form": (e) ->
        e.preventDefault()
        collection =
            name: $(e.target).find("[name=name]").val()
            description: $(e.target).find("[name=description]").val()
            contactEmail: $(e.target).find("[name=contactEmail]").val()
            hostInstitution: $(e.target).find("[name=hostInstitution]").val()
            phenotypes: $(e.target).find("[name=phenotypes]").val()?.split(",")
            specimenTypes: $(e.target).find("[name=specimenTypes]").val()?.split(",")
            ethnicities: $(e.target).find("[name=ethnicities]").val()?.split(",")
            participantCount: parseInt $(e.target).find("[name=participantCount]").val()
            notes: $(e.target).find("[name=notes]").val()
        Meteor.call "collection", collection, (error, id) ->
            if error then Alert.add error.message, "danger"
            else
                Alert.add "Successfully added collection.", "success"
                Router.go "listCollections"
