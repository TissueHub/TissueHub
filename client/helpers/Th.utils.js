
var Th;

Th = window.Th = {};

Th.makeFiltersFromTerms = function(terms) {
  var filters, makefilter, term;
  makefilter = function(term) {
    var filter;
    return filter = {
      $or: [
        {
          hostInstitution: {
            $regex: term,
            $options: "i"
          }
        }, {
          name: {
            $regex: term,
            $options: "i"
          }
        }, {
          description: {
            $regex: term,
            $options: "i"
          }
        }, {
          ethnicities: {
            $regex: term,
            $options: "i"
          }
        }, {
          phenotypes: {
            $regex: term,
            $options: "i"
          }
        }, {
          specimenTypes: {
            $regex: term,
            $options: "i"
          }
        }
      ]
    };
  };
  filters = {
    $and: (function() {
      var i, len, ref, results;
      ref = terms.split(",");
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        term = ref[i];
        if (term) {
          results.push(makefilter(term));
        }
      }
      return results;
    })()
  };
  return filters;
};

Th.fillForm = function(form, data) {
  var fillField, i, key, len, ref;
  fillField = function(key) {
    return $("[name=\"" + key + "\"]", form).val(data[key]);
  };
  ref = Object.keys(data);
  for (i = 0, len = ref.length; i < len; i++) {
    key = ref[i];
    fillField(key);
  }
  return form;
};

Th.getOrganizationMembers = function(organization) {
  var allMembers, members, owners, ref, ref1;
  owners = (ref = organization.owners) != null ? ref.map(function(ownerId) {
    return {
      _id: ownerId,
      owner: true
    };
  }) : void 0;
  members = (ref1 = organization.members) != null ? ref1.map(function(memberId) {
    return {
      _id: memberId
    };
  }) : void 0;
  allMembers = members ? _.union(owners, members) : owners;
  allMembers.forEach(function(member) {
    var memberInfo;
    memberInfo = Meteor.users.findOne({
      _id: member._id
    });
    member.username = memberInfo.username;
    member.profile = _.pick(memberInfo.profile, "name");
    member.email = getEmail(memberInfo);
    return member.displayName = member.profile.name || member.email;
  });
  return allMembers;
};

Th.subscribeAndQueryUsers = function(term) {
  var query, users;
  query = {
    $or: [
      {
        "profile.name": {
          $regex: term,
          $options: "i"
        }
      }, {
        "profile.email": {
          $regex: term,
          $options: "i"
        }
      }, {
        "emails": {
          $elemMatch: {
            "address": {
              $regex: term,
              $options: "i"
            }
          }
        }
      }, {
        "services.github.email": {
          $regex: term,
          $options: "i"
        }
      }, {
        "services.google.email": {
          $regex: term,
          $options: "i"
        }
      }
    ]
  };
  Meteor.subscribe("users", query);
  users = Meteor.users.find(query);
  return {
    results: users.map(function(user) {
      user.id = user._id;
      user.text = user.profile.name || getEmail(user);
      return user;
    })
  };
};

Th.subscribeAndQueryOrganizations = function(term) {
  var organizations, query;
  query = {
    filter: {
      name: {
        $regex: term,
        $options: "i"
      }
    },
    limit: 5
  };
  Meteor.subscribe("organizations", query);
  organizations = Organizations.find(query.filter);
  return {
    results: organizations.map(function(organization) {
      organization.id = organization._id;
      organization.text = organization.name;
      return organization;
    })
  };
};
