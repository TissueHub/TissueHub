
Template.addcollection.helpers({
  initialContactEmail: function() {
    return getEmail(Meteor.user());
  }
});

Template.addcollection.events({
  "submit form": function(e) {
    var collection, ref, ref1, ref2;
    e.preventDefault();
    function arrayVal(selector, e) {
      let val = $(e.target).find(selector).val();
      return val.split(",");
    }
    collection = {
      name: $(e.target).find("[name=name]").val(),
      description: $(e.target).find("[name=description]").val(),
      contactEmail: $(e.target).find("[name=contactEmail]").val(),
      hostInstitution: $(e.target).find("[name=hostInstitution]").val(),
      phenotypes: arrayVal("[name=phenotypes]", e),
      specimenTypes: arrayVal("[name=specimenTypes]", e),
      ethnicities: arrayVal("[name=ethnicities]", e),
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
