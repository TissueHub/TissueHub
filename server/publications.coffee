Meteor.publish "collections", (options) ->
    if options then Collections.find options?.filter or {}, options else Collections.find()

Meteor.publish "organizations", (options) ->
    if options then Organizations.find options?.filter or {}, options else Organizations.find()