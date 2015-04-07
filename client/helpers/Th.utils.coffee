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
    return allMembers