Template.vieworganization.helpers
    allMembers: -> Th.getOrganizationMembers @
    ownsOrganization: -> ownsOrganization Meteor.userId(), @
    parent: -> Organizations.findOne _id: @memberOf