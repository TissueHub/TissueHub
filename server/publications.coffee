Meteor.publish "collections", (options) ->
    if options then Collections.find options?.filter or {}, options else Collections.find()

Meteor.publish "organizations", (options) ->
    if options then Organizations.find options?.filter or options, options else Organizations.find()

Meteor.publish "publicUsers", (id) ->
    if id then Meteor.users.find {_id: id}, {fields: {_id: 1, 'profile.name': 1, username: 1, 'profile.email': 1, 'emails': 1}}

Meteor.publish "usersForOrganization", (id) ->
    organization = Organizations.findOne _id: id
    Meteor.users.find { $or: [{ _id: { $in: organization.owners or [] }}, { _id: { $in: organization.members or [] }}]}

Meteor.publish "users", (query) ->
    Meteor.users.find query, {fields: {_id: 1, 'profile.name': 1, username: 1, 'profile.email': 1, 'emails': 1}, limit: 5}