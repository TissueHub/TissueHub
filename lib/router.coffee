CollectionListController = RouteController.extend
    template: "listcollections"
    increment: 25
    getAndSetOptions: ->
        options =
            sort: dateCreated: -1
            limit: parseInt(@params.limit,10) or @increment
        if @params.q then options.filter = Th.makeFiltersFromTerms @params.q
        Session.set "options", options
        options
    waitOn: ->
        Meteor.subscribe "collections", @getAndSetOptions()
    onBeforeAction: ->
        Session.set "searchTerms", @params.q

Router.configure
    layoutTemplate: "layout"
    loadingTemplate: "loading"

Router.map ->
    @route "home",
        path: "/"
        template: "home"
    @route "listCollections",
        path: "/collections"
        controller: CollectionListController
    @route "addCollection",
        path: "/collections/new"
        template: "addcollection"
    @route "viewCollection",
        path: "/collections/:_id"
        template: "viewcollection"
        waitOn: ->
            Meteor.subscribe "collections"
        data: -> Collections.findOne @params._id
    @route "editCollection",
        path: "/collections/:_id/edit"
        template: "editcollection"
        waitOn: ->
            Meteor.subscribe "collections"
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
