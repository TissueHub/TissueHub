UI.registerHelper("activeRouteClass", function(routeName) {
  var currentRoute = Router.current();
  if (currentRoute && currentRoute.route && currentRoute.route.getName && currentRoute.route.getName() === routeName) {
    return "active";
  }
});
