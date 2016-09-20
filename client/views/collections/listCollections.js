
var setTerms;

setTerms = function() {
  var terms;
  terms = $("[name=search]").val();
  if (terms) {
    return Router.go("listCollections", null, {
      query: "q=" + terms
    });
  } else {
    return Router.go("listCollections");
  }
};

Template.listcollections.helpers({
  collections: function() {
    var options;
    options = Session.get("options");
    return Collections.find((options != null ? options.filter : void 0) || {});
  },
  moreCollections: function() {
    var ref;
    return Collections.find().count() === ((ref = Session.get("options")) != null ? ref.limit : void 0);
  }
});

Template.listcollections.events({
  "input [name=search]": setTerms,
  "change [name=search]": setTerms,
  "click .label": function(e) {
    var label;
    e.preventDefault();
    label = $(e.target).text();
    return $("[name=search]").val(($("[name=search]").val() ? ($("[name=search]").val()) + "," + label : label)).trigger("change");
  },
  "click .share": function(e) {
    return window.prompt("Copy the URL below to share your search", window.location.href);
  },
  "click [name=more]": function(e, t) {
    var options;
    options = Session.get("options");
    options.limit += 25;
    Session.set("options", options);
    return Meteor.subscribe("collections", options);
  }
});

Template.listcollections.rendered = function() {
  this.$("[data-toggle='tooltip']").tooltip();
  return this.$("[name=search]").val(Session.get("searchTerms")).select2({
    tags: [],
    multiple: true,
    simple_tags: true,
    tokenSeparators: [" "],
    dropdownCssClass: 'hidden'
  });
};
