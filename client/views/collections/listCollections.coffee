setTerms = ->
    terms = $("[name=search]").val()
    if terms then Router.go "listCollections", null, query: "q=#{terms}" else Router.go "listCollections"

Template.listcollections.helpers
    collections: -> Collections.find()
    moreCollections: -> Collections.find().count() is Session.get("options")?.limit

Template.listcollections.events
    "input [name=search]": setTerms
    "change [name=search]": setTerms
    "click .label": (e) ->
        label = $(e.target).text()
        $("[name=search]")
            .val (if $("[name=search]").val() then "#{$("[name=search]").val()},#{label}" else label)
            .trigger "change"
    "click .share": (e) ->
        window.prompt "Copy the URL below to share your search", window.location.href
    "click [name=more]": (e, t) ->
        options = Session.get "options"
        options.limit += 25
        Session.set "options", options
        Meteor.subscribe "collections", options

Template.listcollections.rendered = ->
    @$("[data-toggle='tooltip']").tooltip()
    @$ "[name=search]"
        .val Session.get "searchTerms"
        .select2
            tags: []
            multiple: true
            simple_tags: true
            tokenSeparators: [" "]
            dropdownCssClass: 'hidden' # Hides the Select2 dropdown when typing.
