Template.editablememberlist.helpers
    allMembers: -> Th.getOrganizationMembers @

Template.editablememberlist.rendered = ->
    $ "input.addusername"
        .select2
            minimumInputLength: 2
            query: (query) ->
                query.callback Th.subscribeAndQueryUsers query.term