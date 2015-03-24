Package.describe({
	name: "velocity:test-proxy",
	summary: "Dynamically created package to expose test files to mirrors",
	version: "0.0.4",
	debugOnly: true
});

Package.onUse(function (api) {
	api.use("coffeescript", ["client", "server"]);
	api.add_files("tests/jasmine/client/integration/_wait_for_router_helper.js",["client"]);
	api.add_files("tests/jasmine/client/integration/addcollectionTemplateSpec.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/integrationHelpers.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/layoutSpec.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/listcollectionsTemplateSpec.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/navbarSpec.coffee",["client"]);
	api.add_files("tests/jasmine/client/integration/viewcollectionTemplateSpec.coffee",["client"]);
	api.add_files("tests/jasmine/server/integration/placeholderSpec.coffee",["server"]);
});