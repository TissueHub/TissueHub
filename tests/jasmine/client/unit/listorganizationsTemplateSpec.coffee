describe "Template listorganizations", ->

    it "helper \"organizations\" queries Organizations.find", ->
        spyOn Organizations, "find"
            .and.returnValue Help.data.organizations
        result = Help.getHelper(Template.listorganizations, "organizations")()
        expect(result).toEqual Help.data.organizations
        expect(Organizations.find).toHaveBeenCalled()

describe "Template listorganizations renders", ->

    organizationsSpy = div = null

    checkSpys = ->
        expect(organizationsSpy).toHaveBeenCalled()

    beforeEach ->
        organizationsSpy = Help.spyOnHelper Template.listorganizations, "organizations", ->
            return Help.data.organizations

    beforeEach ->
        div = document.createElement "div"
        Blaze.render Template.listorganizations, div

    it "the list of organizations.", ->
        expect($(div).find("tbody tr").length).toEqual Help.data.organizations.length