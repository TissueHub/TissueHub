
Meteor.publish("collections", function(options) {
  if (options) {
    return Collections.find((options != null ? options.filter : void 0) || {}, options);
  } else {
    return Collections.find();
  }
});

Meteor.publish("organizations", function(options) {
  if (options) {
    return Organizations.find((options != null ? options.filter : void 0) || options, options);
  } else {
    return Organizations.find();
  }
});

Meteor.publish("publicUsers", function(id) {
  if (id) {
    return Meteor.users.find({
      _id: id
    }, {
      fields: {
        _id: 1,
        'profile.name': 1,
        username: 1,
        'profile.email': 1,
        'emails': 1
      }
    });
  }
});

Meteor.publish("usersForOrganization", function(id) {
  var organization;
  organization = Organizations.findOne({
    _id: id
  });
  return Meteor.users.find({
    $or: [
      {
        _id: { $in: organization.owners || [] }
      }, {
        _id: { $in: organization.members || [] }
      }
    ]
  });
});

Meteor.publish("users", function(query) {
  return Meteor.users.find(query, {
    fields: {
      _id: 1,
      'profile.name': 1,
      username: 1,
      'profile.email': 1,
      'emails': 1
    },
    limit: 5
  });
});

Meteor.publish("specimen", function(collectionId, specimenId) {
  return [
    Collections.find({ _id: collectionId }),
    Specimens.find({ _id: specimenId })
  ];
});
