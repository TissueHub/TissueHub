
Template.viewcollection.helpers({
  canEdit: function() {
    return canEdit(Meteor.userId(), this);
  },
  mailtoLink: function() {
    var contactEmail, ref;
    contactEmail = (ref = this.contactEmail) != null ? ref.replace(/\ /g, "") : void 0;
    return "mailto:" + contactEmail + "?cc=collaboration_coordination@tissuehub.org&subject=Collaboration%20on%20" + this.name;
  },
  managingOrganizationName: function() {
    return Organizations.findOne({
      _id: this.managingOrganization
    }).name;
  },
  selector: function() {
    return {
      partOf: this._id
    };
  }
});

Template.viewcollection.events({
  "click .delete": function(e) {
    var collectionId;
    e.preventDefault();
    if (confirm("Delete this collection?")) {
      collectionId = this._id;
      Collections.remove(collectionId);
      return Router.go("listCollections");
    }
  }
});
