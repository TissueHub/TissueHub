Template.viewprofile.helpers
    raw: -> JSON.stringify @, null, 2
    ownProfile: -> Meteor.userId() == @_id
    email: -> getEmail @
