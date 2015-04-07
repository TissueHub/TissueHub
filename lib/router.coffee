CollectionListController = RouteController.extend
    template: "listcollections"
    increment: 25
    getAndSetOptions: ->
        options =
            sort: dateCreated: -1
            limit: parseInt(@params.limit,10) or @increment
        if @params.query?.q then options.filter = Th.makeFiltersFromTerms @params.query.q
        Session.set "options", options
        options
    waitOn: ->
        Meteor.subscribe "collections", @getAndSetOptions()
    onBeforeAction: ->
        Session.set "searchTerms", @params.query?.q
        @next()

Router.configure
    layoutTemplate: "layout"
    loadingTemplate: "loading"

Router.map ->
    @route "home",
        path: "/"
        template: "home"
    @route "admin",
        path: "/admin"
        template: "accountsAdmin"
        onBeforeAction: ->
            if Meteor.loggingIn()
                @render @loadingTemplate
            else if not Roles.userIsInRole Meteor.user(), ["admin"]
                @redirect "/"
            @next()
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
    @route "viewUserProfile",
        path: "/profile/:_id"
        template: "viewprofile"
        waitOn: ->
            Meteor.subscribe "publicUsers", @params._id
        data: -> Meteor.users.findOne @params._id
    @route "listOrganizations",
        path: "/organizations"
        template: "listorganizations"
        waitOn: -> Meteor.subscribe "organizations"
    @route "addOrganization",
        path: "/organizations/new"
        template: "addorganization"
    @route "viewOrganization",
        path: "/organizations/:_id"
        template: "vieworganization"
        waitOn: ->
            Meteor.subscribe "organizations", _id: @params._id
            Meteor.subscribe "usersForOrganization", @params._id
        data: -> Organizations.findOne @params._id
    @route "editOrganization",
        path: "/organizations/:_id/edit"
        template: "editorganization"
        waitOn: ->
            Meteor.subscribe "organizations", _id: @params._id
            Meteor.subscribe "usersForOrganization", @params._id
        data: -> Organizations.findOne @params._id

Router.onAfterAction ->
    ga? "send", "pageview"

Router.onBeforeAction "loading"
