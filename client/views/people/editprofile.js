
Template.editprofile.helpers({
  raw: function() {
    return JSON.stringify(this, null, 2);
  },
  email: function() {
    return getEmail(this);
  }
});

Template.editprofile.events({
  "submit form": function(e) {
    var profile, userId;
    e.preventDefault();
    userId = Meteor.userId();
    profile = {
      name: $(e.target).find("[name=name]").val(),
      email: $(e.target).find("[name=email]").val()
    };
    return Meteor.users.update(userId, {
      $set: {
        profile: profile
      }
    }, function(error) {
      if (error) {
        return Alert.add(error.message, "danger");
      } else {
        Alert.add("Profile Edited", "success");
        return Router.go("viewProfile");
      }
    });
  }
});
