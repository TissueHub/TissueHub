describe "TissueHub Navigation Bar - Admins", ->

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