
Template.viewprofile.helpers({
  raw: function() {
    return JSON.stringify(this, null, 2);
  },
  ownProfile: function() {
    return Meteor.userId() === this._id;
  },
  email: function() {
    return getEmail(this);
  }
});
