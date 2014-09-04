Meteor.methods
    collection: (collectionAttributes) ->
        user = Meteor.user()

        # Validation
        if not user then throw new Meteor.Error 401, "You must be logged in to create collections."
        if not hasAttributes collectionAttributes, ["name"]
            throw new Meteor.Error 422, "Collection name required"

        collection = _.extend collectionAttributes,
            owner: user._id
            creator: user._id
            dateCreated: new Date().getTime()

        collectionId = Collections.insert collection
