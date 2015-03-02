// check that the userId specified owns the documents
ownsDocument = function(userId, doc) {
  return !!doc && doc.owner === userId;
}

// check that the userId specified is an admin
admin = function(userId) {
    return Roles.userIsInRole(userId, ["admin"]);
}

// check that the userId specified is a curator
curator = function(userId) {
    return Roles.userIsInRole(userId, ["curator"]);
}

// check that the userId specified has permission to edit the document
// Users can edit a document if
// 1. they own it
// 2. they are a curator
// 3. they are an admin
canEdit = function(userId, doc) {
    return ownsDocument(userId, doc) || curator(userId) || admin(userId);
}
