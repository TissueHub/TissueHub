
this.Collections = new Meteor.Collection("collections");

Collections.allow({
  update: canEdit,
  remove: canEdit
});

Meteor.methods({
  collection: function(collectionAttributes) {
    var collection, collectionId, user;
    user = Meteor.user();
    if (!user) {
      throw new Meteor.Error(401, "You must be logged in to create collections.");
    }
    if (!hasAttributes(collectionAttributes, ["name"])) {
      throw new Meteor.Error(422, "Collection name required");
    }
    collection = _.extend(collectionAttributes, {
      owner: user._id,
      creator: user._id,
      dateCreated: new Date().getTime()
    });
    return collectionId = Collections.insert(collection);
  }
});
