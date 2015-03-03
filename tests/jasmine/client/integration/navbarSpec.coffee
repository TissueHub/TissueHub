describe "TissueHub Navigation Bar", ->

    header = null

    describe "Admins", ->

        beforeEach (done) ->
            Help.loginAdmin done

        beforeEach -> # Must render after login
            header = document.createElement "DIV"
            Blaze.render Template.header, header

        afterEach (done) ->
            Help.logout done

        it "includes the \"Admin\" nav", ->
            expect($(header).find(".navbar a[href=\"/admin\"]").length).toBe 1