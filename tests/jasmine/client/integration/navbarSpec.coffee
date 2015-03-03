describe "TissueHub Navigation Bar for Admins", ->

    header = null

    beforeEach (done) ->
        Help.loginAdmin done

    beforeEach -> # Must render after login
        header = document.createElement "DIV"
        Blaze.render Template.header, header

    afterEach (done) ->
        Help.logout done

    it "includes the \"Admin\" nav", ->
        expect($(header).find(".navbar a[href=\"/admin\"]").length).toBe 1

    it "includes the \"My Profile\" nav", ->
        expect($(header).find(".navbar a[href=\"/profile\"]").length).toBe 1

describe "TissueHub Navigation Bar for Users", ->

    header = null

    beforeEach (done) ->
        Help.loginIsa done

    beforeEach -> # Must render after login
        header = document.createElement "DIV"
        Blaze.render Template.header, header

    afterEach (done) ->
        Help.logout done

    it "does not include the \"Admin\" nav", ->
        expect($(header).find(".navbar a[href=\"/admin\"]").length).toBe 0

    it "includes the \"My Profile\" nav", ->
        expect($(header).find(".navbar a[href=\"/profile\"]").length).toBe 1