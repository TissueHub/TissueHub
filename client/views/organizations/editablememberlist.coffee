Template.editablememberlist.helpers
    allMembers: -> Th.getOrganizationMembers @

Template.editablememberlist.rendered = ->
    $ "input.addusername"
        .select2
            minimumInputLength: 2
            query: (query) ->
                query.callback Th.subscribeAndQueryUsers query.term

Template.editablememberlist.events
    "change [name=addusername]": (e) ->
        e.preventDefault()
        organizationId = Template.parentData(1)._id
        Organizations.update organizationId, $push: members: $(e.target).val()

Template.editablemember.events
    "click button.remove": (e) ->
        e.preventDefault()
        organizationId = Template.parentData(1)._id
        Organizations.update organizationId, $pull: members: @_id
    "click input.owner": (e) ->
        e.preventDefault()
        if @_id is Meteor.userId() then return
        if e.target.checked # Adding an owner
            push = owners: @_id
            pull = members: @_id
        else
            push = members: @_id
            pull = owners: @_id
        organizationId = Template.parentData(1)._id
        Organizations.update organizationId, { $pull: pull, $push: push }