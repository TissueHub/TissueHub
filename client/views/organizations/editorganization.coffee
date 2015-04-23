Template.editorganization.events
    "submit form": (e) ->
        e.preventDefault()
        organizationId = @_id
        organization =
            name: $(e.target).find("[name=name]").val()
            description: $(e.target).find("[name=description]").val()
            url: $(e.target).find("[name=url]").val()
            memberOf: $(e.target).find("[name=memberOf]").val()
        Organizations.update organizationId, $set: organization, (error) ->
            if error then Alert.add error.message, "danger"
            else
                Alert.add "Successfully edited organization.", "success"
                Router.go "listOrganizations"

Template.editorganization.rendered = ->
    $ "input[name=memberOf]"
        .select2
            minimumInputLength: 2
            query: (query) ->
                query.callback Th.subscribeAndQueryOrganizations query.term
    if !!@data and !!@data.memberOf
        parentOrganization = Organizations.findOne "_id": @data.memberOf
        $ "input[name=memberOf]"
            .select2 "data", { id: parentOrganization._id, text: parentOrganization.name }