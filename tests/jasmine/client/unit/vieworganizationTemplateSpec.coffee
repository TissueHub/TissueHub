describe "Template vieworganization renders", ->

    div = organization = null

    beforeEach ->
        organization = Help.data.organizations[0]
        div = Help.renderTemplate(Template.vieworganization, organization)

    it "a link back to the organization list", ->
        expect($(div).find("a[href=\"/organizations\"]").text()).toEqual "Back to Organization List"

    it "the name of the organization", ->
        expect($(div).find("h2").text()).toEqual "#{organization.name} #{organization.url}"

    it "the description of the organization", ->
        expect($(div).find("p.lead").text()).toEqual organization.description

    it "the url of the organization", ->
        expect($(div).find("h2 small a").text()).toEqual organization.url