Template.editorganization.events
    "submit form": (e) ->
        e.preventDefault()
        organizationId = @_id
        organization =
            name: $(e.target).find("[name=name]").val()
            description: $(e.target).find("[name=description]").val()
            url: $(e.target).find("[name=url]").val()
        Organizations.update organizationId, $set: organization, (error) ->
            if error then Alert.add error.message, "danger"
            else
                Alert.add "Successfully edited organization.", "success"
                Router.go "listOrganizations"