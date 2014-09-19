Router.configure
    layoutTemplate: "layout"
    waitOn: ->
        Meteor.subscribe "collections"

Router.map ->
    @route "home",
        path: "/"
        template: "home"
    @route "listCollections",
        path: "/collections"
        template: "listcollections"
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
