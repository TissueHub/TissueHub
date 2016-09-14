
Template.addcollection.helpers({
  initialContactEmail: function() {
    return getEmail(Meteor.user());
  }
});

Template.addcollection.events({
  "submit form": function(e) {
    var collection, ref, ref1, ref2;
    e.preventDefault();
    collection = {
      name: $(e.target).find("[name=name]").val(),
      description: $(e.target).find("[name=description]").val(),
      contactEmail: $(e.target).find("[name=contactEmail]").val(),
      hostInstitution: $(e.target).find("[name=hostInstitution]").val(),
      phenotypes: (ref = $(e.target).find("[name=phenotypes]").val()) != null ? ref.split(",") : void 0,
      specimenTypes: (ref1 = $(e.target).find("[name=specimenTypes]").val()) != null ? ref1.split(",") : void 0,
      ethnicities: (ref2 = $(e.target).find("[name=ethnicities]").val()) != null ? ref2.split(",") : void 0,
      participantCount: parseInt($(e.target).find("[name=participantCount]").val()),
      notes: $(e.target).find("[name=notes]").val()
    };
    return Meteor.call("collection", collection, function(error, id) {
      if (error) {
        return Alert.add(error.message, "danger");
      } else {
        Alert.add("Successfully added collection.", "success");
        return Router.go("listCollections");
      }
    });
  }
});
