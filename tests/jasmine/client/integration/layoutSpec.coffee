describe "TissueHub Layout", ->

    it "includes the \"TissueHub\" brand in the navbar", ->
        expect($(".navbar-brand").text()).toEqual "TissueHub"

    it "includes the \"Collections\" nav when logged out", ->
        expect($(".navbar a:contains(\"Collections\")").length).toBe 1