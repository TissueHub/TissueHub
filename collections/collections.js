Collections = new Meteor.Collection("collections");

Collections.allow({
    update: ownsDocument,
    remove: ownsDocument
});

