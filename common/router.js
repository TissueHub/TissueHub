
var CollectionListController;

CollectionListController = RouteController.extend({
  template: "listcollections",
  increment: 25,
  getAndSetOptions: function() {
    var options, ref;
    options = {
      sort: {
        dateCreated: -1
      },
      limit: parseInt(this.params.limit, 10) || this.increment
    };
    if ((ref = this.params.query) != null ? ref.q : void 0) {
      options.filter = Th.makeFiltersFromTerms(this.params.query.q);
    }
    Session.set("options", options);
    return options;
  },
  waitOn: function() {
    return Meteor.subscribe("collections", this.getAndSetOptions());
  },
  onBeforeAction: function() {
    var ref;
    Session.set("searchTerms", (ref = this.params.query) != null ? ref.q : void 0);
    return this.next();
  }
});

Router.configure({
  layoutTemplate: "layout",
  loadingTemplate: "loading"
});

Router.map(function() {
  this.route("home", {
    path: "/",
    template: "home"
  });
  this.route("admin", {
    path: "/admin",
    template: "accountsAdmin",
    onBeforeAction: function() {
      if (Meteor.loggingIn()) {
        this.render(this.loadingTemplate);
      } else if (!Roles.userIsInRole(Meteor.user(), ["admin"])) {
        this.redirect("/");
      }
      return this.next();
    }
  });
  this.route("listCollections", {
    path: "/collections",
    controller: CollectionListController
  });
  this.route("addCollection", {
    path: "/collections/new",
    template: "addcollection"
  });
  this.route("viewCollection", {
    path: "/collections/:_id",
    template: "viewcollection",
    waitOn: function() {
      Meteor.subscribe("organizations");
      return Meteor.subscribe("collections");
    },
    data: function() {
      return Collections.findOne(this.params._id);
    }
  });
  this.route("editCollection", {
    path: "/collections/:_id/edit",
    template: "editcollection",
    waitOn: function() {
      Meteor.subscribe("collections");
      return Meteor.subscribe("organizations");
    },
    data: function() {
      return Collections.findOne(this.params._id);
    }
  });
  this.route("viewProfile", {
    path: "/profile",
    template: "viewprofile",
    data: function() {
      return Meteor.user();
    }
  });
  this.route("editProfile", {
    path: "/profile/edit",
    template: "editprofile",
    data: function() {
      return Meteor.user();
    }
  });
  this.route("viewUserProfile", {
    path: "/profile/:_id",
    template: "viewprofile",
    waitOn: function() {
      return Meteor.subscribe("publicUsers", this.params._id);
    },
    data: function() {
      return Meteor.users.findOne(this.params._id);
    }
  });
  this.route("listOrganizations", {
    path: "/organizations",
    template: "listorganizations",
    waitOn: function() {
      return Meteor.subscribe("organizations");
    }
  });
  this.route("addOrganization", {
    path: "/organizations/new",
    template: "addorganization"
  });
  this.route("viewOrganization", {
    path: "/organizations/:_id",
    template: "vieworganization",
    waitOn: function() {
      Meteor.subscribe("organizations");
      return Meteor.subscribe("usersForOrganization", this.params._id);
    },
    data: function() {
      return Organizations.findOne(this.params._id);
    }
  });
  this.route("editOrganization", {
    path: "/organizations/:_id/edit",
    template: "editorganization",
    waitOn: function() {
      Meteor.subscribe("organizations");
      return Meteor.subscribe("usersForOrganization", this.params._id);
    },
    data: function() {
      return Organizations.findOne(this.params._id);
    }
  });
  this.route("addSpecimen", {
    path: "/collections/:_id/specimens/new",
    template: "addspecimen",
    data: function() {
      return {
        collection: Collections.findOne({ _id: this.params._id }),
        specimen: { partOf: [this.params._id] }
      };
    },
    waitOn: function() {
      return Meteor.subscribe("collections");
    }
  });
  this.route("addSpecimenBulk", {
    path: "/collections/:_id/specimens/bulkAdd",
    template: "addspecimenbulk",
    data: function() {
      return {
        collection: Collections.findOne({ _id: this.params._id })
      };
    },
    waitOn: function() {
      return Meteor.subscribe("collections");
    }
  });
  this.route("listSpecimens", {
    path: "/collections/:_id/specimens",
    template: "listspecimens",
    waitOn: function() {
      return Meteor.subscribe("collections");
    },
    data: function() {
      return {
        collection: Collections.findOne(this.params._id)
      };
    }
  });
  this.route("viewSpecimen", {
    path: "/collections/:collectionId/specimens/:specimenId",
    template: "viewspecimen",
    waitOn: function() {
      return Meteor.subscribe("specimen", this.params.collectionId, this.params.specimenId);
    },
    data: function() {
      return {
        collection: Collections.findOne(this.params.collectionId),
        specimen: Specimens.findOne(this.params.specimenId)
      };
    }
  });
  return this.route("editSpecimen", {
    path: "/collections/:collectionId/specimens/:specimenId/edit",
    template: "editspecimen",
    waitOn: function() {
      return Meteor.subscribe("specimen", this.params.collectionId, this.params.specimenId);
    },
    data: function() {
      return {
        collection: Collections.findOne(this.params.collectionId),
        specimen: Specimens.findOne(this.params.specimenId)
      };
    }
  });
});

Router.onAfterAction(function() {
  return typeof ga === "function" ? ga("send", "pageview") : void 0;
});

Router.onBeforeAction("loading");

AccountsTemplates.configureRoute("changePwd");
AccountsTemplates.configureRoute("enrollAccount");
AccountsTemplates.configureRoute("resetPwd");
AccountsTemplates.configureRoute("signIn");
AccountsTemplates.configureRoute("signUp");
