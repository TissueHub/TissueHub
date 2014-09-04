Router.configure
    layoutTemplate: "layout"

Router.map ->
    @route "home",
        path: "/"
        template: "home"
    @route "listCollections",
        path: "/collections"
        template: "listcollections"
        waitOn: ->
            Meteor.subscribe "collections"
    @route "addCollection",
        path: "/collections/new"
        template: "addcollection"
