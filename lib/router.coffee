CollectionListController = RouteController.extend
    template: "listcollections"
    increment: 5
    getOptions: ->
        options =
            sort: dateCreated: -1
            limit: 25
        if @params.q then options.filter = Th.makeFiltersFromTerms @params.q
        options
    waitOn: ->
        options = @getOptions()
        Meteor.subscribe "collections", options
    data: ->
        options = @getOptions()
        collections: Collections.find options?.filter or {}, options
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
