BulkInterfaces = {}

if Meteor.isClient then Template.registerHelper "BulkInterfaces", BulkInterfaces

BulkInterfaces.addSpecimens = new BulkInterface.Interface
    name: "addSpecimens"
    collection: Specimens
    permissions:
        update: canEditSpecimen
    key: "localId"