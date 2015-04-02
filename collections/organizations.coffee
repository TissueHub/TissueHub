@Organizations = new Meteor.Collection("organizations")

Meteor.methods
    createOrganization: (organizationAttributes) ->
        user = Meteor.user()

        # Validation
        if not user then throw new Meteor.Error 401, "You must be logged in to create organizations."
        if not hasAttributes organizationAttributes, ["name"]
            throw new Meteor.Error 422, "Organization name required"

        organization = _.extend organizationAttributes,
            owners: [user._id]
            creator: user._id
            dateCreated: Date.now()

        Organizations.insert organization