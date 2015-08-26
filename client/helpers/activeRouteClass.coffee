UI.registerHelper "activeRouteClass", (routeName) ->
    "active" if Router.current()?.route?.getName() is routeName
