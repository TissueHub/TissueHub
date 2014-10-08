Meteor.publish "collections", (options) -> Collections.find options?.filter or {}, options
