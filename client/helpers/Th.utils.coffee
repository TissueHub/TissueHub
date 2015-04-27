Th = window.Th = {}

Th.makeFiltersFromTerms = (terms) ->
    makefilter = (term) ->
        filter = $or: [
            { hostInstitution: $regex: term, $options: "i" }
            { name: $regex: term, $options: "i" }
            { description: $regex: term, $options: "i" }
            { ethnicities: $regex: term, $options: "i" }
            { phenotypes: $regex: term, $options: "i" }
            { specimenTypes: $regex: term, $options: "i" }
        ]
    filters = $and: (makefilter term for term in terms.split "," when term)
    filters

Th.fillForm = (form, data) ->
    fillField = (key) ->
        $("[name=\"#{key}\"]", form).val data[key]
    fillField key for key in Object.keys data
    return form

Th.getOrganizationMembers = (organization) ->
    owners = organization.owners?.map (ownerId) -> _id: ownerId, owner: true
    members = organization.members?.map (memberId) -> _id: memberId
    allMembers = if members then _.union owners, members else owners
    allMembers.forEach (member) ->
            memberInfo = Meteor.users.findOne _id: member._id
            member.username = memberInfo.username
            member.profile = _.pick memberInfo.profile, "name"
            member.email = getEmail(memberInfo)
            member.displayName = member.profile.name or member.email
    return allMembers

Th.subscribeAndQueryUsers = (term) ->
    query = $or: [
        { "profile.name": $regex: term, $options: "i" }
        { "profile.email": $regex: term, $options: "i" }
        { "emails": { $elemMatch: { "address": {$regex: term, $options: "i" }}}}
        { "services.github.email": $regex: term, $options: "i" }
        { "services.google.email": $regex: term, $options: "i" }
    ]
    Meteor.subscribe "users", query
    users = Meteor.users.find query
    return {
        results: users.map (user) ->
            user.id = user._id
            user.text = user.profile.name or getEmail(user)
            user
    }

Th.subscribeAndQueryOrganizations = (term) ->
    query =
        filter: name: $regex: term, $options: "i"
        limit: 5
    Meteor.subscribe "organizations", query
    organizations = Organizations.find query.filter
    return {
        results: organizations.map (organization) ->
            organization.id = organization._id
            organization.text = organization.name
            organization
    }