makeFiltersFromTerms = (terms) ->
    makefilter = (term) ->
        filter = $or: [
            { hostInstitution: $regex: term, $options: "i" }
            { name: $regex: term, $options: "i" }
            { description: $regex: term, $options: "i" }
            { ethnicities: $regex: term, $options: "i" }
            { phenotypes: $regex: term, $options: "i" }
            { specimenTypes: $regex: term, $options: "i" }
        ]
    filters = $and: (makefilter term for term in terms.split "," when term)
    filters

setTerms = ->
    terms = $("[name=search]").val()
    if terms then Router.go "listCollections", null, query: "q=#{terms}" else Router.go "listCollections"

Template.listcollections.helpers
    collections: ->
        terms = Session.get "searchTerms"
        if terms
            Collections.find makeFiltersFromTerms terms
        else
            Collections.find()

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
