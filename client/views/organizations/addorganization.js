
Template.addorganization.events({
  "submit form": function(e) {
    var organization;
    e.preventDefault();
    organization = {
      name: $(e.target).find("[name=name]").val(),
      description: $(e.target).find("[name=description]").val(),
      url: $(e.target).find("[name=url]").val()
    };
    return Meteor.call("createOrganization", organization, function(error) {
      if (error) {
        return Alert.add(error.message, "danger");
      } else {
        Alert.add("Successfully added organization.", "success");
        return Router.go("listOrganizations");
      }
    });
  }
});
