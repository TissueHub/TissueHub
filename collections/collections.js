Collections = new Meteor.Collection("collections");

Collections.allow({
    update: canEdit,
    remove: canEdit
});

