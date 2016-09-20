
Template.editablememberlist.helpers({
  allMembers: function() {
    return Th.getOrganizationMembers(this);
  }
});

Template.editablememberlist.rendered = function() {
  return $("input.addusername").select2({
    minimumInputLength: 2,
    query: function(query) {
      return query.callback(Th.subscribeAndQueryUsers(query.term));
    }
  });
};

Template.editablememberlist.events({
  "change [name=addusername]": function(e) {
    var organizationId;
    e.preventDefault();
    organizationId = Template.parentData(1)._id;
    return Organizations.update(organizationId, {
      $push: { members: $(e.target).val() }
    });
  }
});

Template.editablemember.events({
  "click button.remove": function(e) {
    var organizationId;
    e.preventDefault();
    organizationId = Template.parentData(1)._id;
    return Organizations.update(organizationId, {
      $pull: { members: this._id }
    });
  },
  "click input.owner": function(e) {
    var organizationId, pull, push;
    e.preventDefault();
    if (this._id === Meteor.userId()) {
      return;
    }
    if (e.target.checked) {
      push = { owners: this._id };
      pull = { members: this._id };
    } else {
      push = { members: this._id };
      pull = { owners: this._id };
    }
    organizationId = Template.parentData(1)._id;
    return Organizations.update(organizationId, {
      $pull: pull,
      $push: push
    });
  }
});
