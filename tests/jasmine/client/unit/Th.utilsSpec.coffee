describe "Th.fillForm", ->

    data = { firstname: "David", lastname: "Robbins", notPresent: "No Error" }
    formHTML = "<form>
            <input name=\"firstname\" />
            <input name=\"lastname\" />
        </form>"
    form = result = null

    beforeEach ->
        form = $.parseHTML(formHTML)[0]
        result = Th.fillForm form, data

    it "exists", ->
        expect(Th.fillForm).toEqual jasmine.any(Function)

    it "puts each field in data in the appropriate named form field", ->
        expect($("[name=firstname]", form).val()).toEqual data.firstname
        expect($("[name=lastname]", form).val()).toEqual data.lastname

    it "returns the form", ->
        expect(result).toEqual form