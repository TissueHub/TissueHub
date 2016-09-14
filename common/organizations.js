
this.Organizations = new Meteor.Collection("organizations");

Organizations.allow({
  update: ownsOrganization
});

Meteor.methods({
  createOrganization: function(organizationAttributes) {
    var organization, user;
    user = Meteor.user();
    if (!user) {
      throw new Meteor.Error(401, "You must be logged in to create organizations.");
    }
    if (!hasAttributes(organizationAttributes, ["name"])) {
      throw new Meteor.Error(422, "Organization name required");
    }
    organization = _.extend(organizationAttributes, {
      owners: [user._id],
      creator: user._id,
      dateCreated: Date.now()
    });
    return Organizations.insert(organization);
  }
});
