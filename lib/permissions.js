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

// check that the userId specificed belongs to (as an owner or member)
// the document's managingOrganization
belongsToManagingOrganization = function (userId, doc) {
    var organization;
    if (!!doc && !!doc.managingOrganization) {
        organization = Organizations.findOne({_id: doc.managingOrganization})
        return _.contains(organization.members, userId) || _.contains(organization.owners, userId);
    }
    else return false;
}

// check that the userId specified has permission to edit the document
// Users can edit a document if
// 1. they own it
// 2. they are a curator
// 3. they are an admin
// 4. they belong to the collections managing organization
canEdit = function(userId, doc) {
    return ownsDocument(userId, doc) || curator(userId) || admin(userId) || belongsToManagingOrganization(userId, doc) ||false;
}

ownsOrganization = function (userId, organization) {
    return _.contains(organization.owners, userId);
}