Router.configure
    layoutTemplate: "layout"
    loadingTemplate: "loading"
    waitOn: ->
        Meteor.subscribe "collections"

Router.map ->
    @route "home",
        path: "/"
        template: "home"
    @route "listCollections",
        path: "/collections"
        template: "listcollections"
        onBeforeAction: ->
            Session.set "searchTerms", @params.q
    @route "addCollection",
        path: "/collections/new"
        template: "addcollection"
    @route "viewCollection",
        path: "/collections/:_id"
        template: "viewcollection"
        data: -> Collections.findOne @params._id
    @route "editCollection",
        path: "/collections/:_id/edit"
        template: "editcollection"
        data: -> Collections.findOne @params._id
    @route "viewProfile",
        path: "/profile"
        template: "viewprofile"
        data: -> Meteor.user()
    @route "editProfile",
        path: "/profile/edit"
        template: "editprofile"
        data: -> Meteor.user()

Router.onAfterAction ->
    ga? "send", "pageview"

Router.onBeforeAction "loading"
