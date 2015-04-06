Template.addorganization.events
    "submit form": (e) ->
        e.preventDefault()
        organization =
            name: $(e.target).find("[name=name]").val()
            description: $(e.target).find("[name=description]").val()
            url: $(e.target).find("[name=url]").val()
        Meteor.call "createOrganization", organization, (error) ->
            if error then Alert.add error.message, "danger"
            else
                Alert.add "Successfully added organization.", "success"
                Router.go "listOrganizations"