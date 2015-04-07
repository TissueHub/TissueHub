Template.vieworganization.helpers
    allMembers: -> Th.getOrganizationMembers @
    ownsOrganization: -> ownsOrganization Meteor.userId(), @