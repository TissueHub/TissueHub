Template.vieworganization.helpers
    allMembers: ->
        owners = @owners?.map (ownerId) -> _id: ownerId, owner: true
        members = @members?.map (memberId) -> _id: memberId
        allMembers = if members then _.union owners, members else owners
        allMembers.forEach (member) ->
            memberInfo = Meteor.users.findOne _id: member._id
            member.username = memberInfo.username
            member.profile = _.pick memberInfo.profile, "name"
        allMembers
    ownsOrganization: -> ownsOrganization Meteor.userId(), @