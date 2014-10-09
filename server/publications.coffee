Meteor.publish "collections", (options) ->
    if options then Collections.find options?.filter or {}, options else Collections.find()
