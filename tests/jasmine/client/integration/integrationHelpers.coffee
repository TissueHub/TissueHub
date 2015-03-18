Users =
    "New User 1":
        email: "newuser1@example.com"
        password: "password"
    "Isa Tufayl":
        profile:
            name: "Isa Tufayl"
        email: "isa@tufayl.com"
        username: "isa"
        password: "password"
        id: "n6a7DAMaa39tH8DYQ"
    "Admin":
        profile:
            name: "Admin"
        email: "admin@example.com"
        username: "admin"
        password: "password"

now = new Date().getTime()
hour = 1000 * 60 * 60 # ms * sec * min
day = 24 * hour
week = 7 * day
base = now - 10 * hour # base creation time for fixture elements

Collections = [
    {
        name: "RADAR"
        description: "Rheumatoid Arthritis Database and Repository"
        phenotypes: [
            "Rheumatoid arthritis"
        ]
        specimenTypes: [
            "DNA"
            "serial serum samples"
        ]
        ethnicities: [
            "African American"
            "European American"
        ]
        contactEmail: "radar-admin@example.edu"
        hostInstitution: "Example University"
        participantCount: 250
        recruitmentStatus: "active"
        dateCreated: now
        owner: "n6a7DAMaa39tH8DYQ"
    }
    {
        name: "CLEAR"
        description: "Consortium for the Longitudinal Evaluation of African Americans with Rheumatiod Arthritis"
        phenotypes: [
            "Rheumatoid arthritis"
            "African American"
        ]
        specimenTypes: [
            "DNA"
            "Serum"
            "Plasma"
            "Demographic Data"
            "Clinical Data"
            "Radiographic Data"
        ]
        ethnicities: [
            "Native American"
            "Asian"
        ]
        contactEmail: "CLEAR-admin@example.edu"
        hostInstitution: "Example University"
        participantCount: 1610
        recruitmentStatus: "closed"
        dateCreated: now - 25 * week
    }
    {
        name: "STRENGTH"
        description: ""
        phenotypes: [
            "Newly diagnosed with breast cancer"
            "90% Caucasian"
        ]
        specimenTypes: [
            "Sera"
        ]
        ethnicities: [
            "European American"
        ]
        contactEmail: "strong@sample.edu"
        hostInstitution: "Sample State University"
        participantCount: 90
        recruitmentStatus: ""
        dateCreated: now - 10 * week
    }
]

@Help =
    loginUser: (user, done) ->
        Meteor.loginWithPassword user.email, user.password, done
    loginIsa: (done) ->
        Help.loginUser Users["Isa Tufayl"], done
    loginAdmin: (done) ->
        Help.loginUser Users["Admin"], done
    logout: (done) ->
        Meteor.logout done
    getHelper: (template, helperName) ->
        template.__helpers.get(helperName)
    callEventHandler: (template, eventName, e) ->
        spyOn Blaze, "getData"
            .and.returnValue {}
        template.__eventMaps[0][eventName].call({templateInstance: -> }, e)
    spyOnHelper: (template, helperName, replacement) ->
        spy = jasmine.createSpy helperName
        if replacement then spy.and.callFake replacement
        template.__helpers.set(helperName, spy)
        return spy
    data:
        users: Users
        collections: Collections