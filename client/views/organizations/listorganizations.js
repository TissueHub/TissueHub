
Template.listorganizations.helpers({
  organizations: function() {
    return Organizations.find();
  }
});
