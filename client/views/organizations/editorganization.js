
Template.editorganization.events({
  "submit form": function(e) {
    var organization, organizationId;
    e.preventDefault();
    organizationId = this._id;
    organization = {
      name: $(e.target).find("[name=name]").val(),
      description: $(e.target).find("[name=description]").val(),
      url: $(e.target).find("[name=url]").val(),
      memberOf: $(e.target).find("[name=memberOf]").val()
    };
    return Organizations.update(organizationId, {
      $set: organization
    }, function(error) {
      if (error) {
        return Alert.add(error.message, "danger");
      } else {
        Alert.add("Successfully edited organization.", "success");
        return Router.go("listOrganizations");
      }
    });
  }
});

Template.editorganization.rendered = function() {
  var parentOrganization;
  $("input[name=memberOf]").select2({
    minimumInputLength: 2,
    query: function(query) {
      return query.callback(Th.subscribeAndQueryOrganizations(query.term));
    }
  });
  if (!!this.data && !!this.data.memberOf) {
    parentOrganization = Organizations.findOne({
      "_id": this.data.memberOf
    });
    return $("input[name=memberOf]").select2("data", {
      id: parentOrganization._id,
      text: parentOrganization.name
    });
  }
};
