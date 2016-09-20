
Template.vieworganization.helpers({
  allMembers: function() {
    return Th.getOrganizationMembers(this);
  },
  ownsOrganization: function() {
    return ownsOrganization(Meteor.userId(), this);
  },
  parent: function() {
    return Organizations.findOne({ _id: this.memberOf });
  }
});
