if Collections.find().count() is 0 and process.env.NODE_ENV is "development"
    now = new Date().getTime()
    hour = 1000 * 60 * 60 # ms * sec * min
    day = 24 * hour
    week = 7 * day
    base = now - 10 * hour # base creation time for fixture elements

    randomInt = (lower, upper) ->
        [lower, upper] = [0, lower]     unless upper?
        [lower, upper] = [upper, lower] if lower > upper
        Math.floor(Math.random() * (upper - lower + 1) + lower)

    takeAFew = (array, count) ->
        _.uniq ( array[randomInt 0, array.length-1] for num in [0..count] )

    takeOne = (array) -> array[randomInt 0, array.length-1]

    # Users
    kallie =
        profile:
            name: "Kallie Emil"
            email: "kallie@example.com"
        username: "kallie"
        password: "password"
    kallie._id = Accounts.createUser kallie

    isa =
        profile:
            name: "Isa Tufayl"
        email: "isa@tufayl.com"
        username: "isa"
        password: "password"
    isa._id = Accounts.createUser isa
    Roles.addUsersToRoles isa._id, ["curator"]

    bob =
        profile:
            name: "Bob Tufayl"
        email: "bob@tufayl.com"
        username: "bob"
        password: "password"
    bob._id = Accounts.createUser bob

    admin =
        profile:
            name: "Admin"
        email: "admin@example.com"
        username: "admin"
        password: "password"
    admin._id = Accounts.createUser admin
    Roles.addUsersToRoles admin._id, ["admin"]

    users = [ kallie, isa, bob, admin ]

    phenotypes = [
        "Rheumatoid arthritis"
        "Breast Cancer"
        "Newly diagnosed with breast cancer"
        "90% Caucasian"
        "No autoimmune disease (CSQ negative)"
        "SLE on dialysis or with transplant"
        "healthy"
        "vaccinated"
        "Prostate Cancer"
        "Lung Cancer"
        "Colorectal Cancer"
        "Ovarian Cancer"
        "Healthy Controls"
        "Warfarin reversal"
    ]

    ethnicities = [
        "AA"
        "EA"
        "African American"
        "European American"
        "Caucasian"
        "ALL"
        "non-Hispanic White"
    ]

    specimenTypes = [
        "DNA"
        "Serum"
        "Plasma"
        "Urine"
        "RNA"
        "cDNA"
        "Brain tissue"
        "Fresh Blood"
        "EBV-transformed LCL"
        "Buccal Cells"
        "Tissue"
        "Microarray Data"
        "Biopsy"
        "Histopathology"
        "PBMC"
    ]

    Collections.insert
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
            owner: kallie._id
    Collections.insert
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
            owner: kallie._id
    Collections.insert
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
            owner: isa._id
    Collections.insert
            name: "CCTS Core Laboratory"
            description: null
            phenotypes: [
            ]
            specimenTypes: [
                "Genomic DNA"
                "Serum"
                "Plasma"
                "Buffy Coats"
            ]
            ethnicities: [
                "Pacific Islander"
            ]
            contactEmail: "strong@sample.edu"
            hostInstitution: "UAB"
            participantCount: null
            recruitmentStatus: "active"
            dateCreated: now - 15 * week
            owner: isa._id

    insertRandomCollection = (n) ->
        user = takeOne users
        Collections.insert
            name: "Test Collection #{n}"
            description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            phenotypes: takeAFew phenotypes, randomInt(1,4)
            ethnicities: takeAFew ethnicities, randomInt(1,4)
            specimenTypes: takeAFew specimenTypes, randomInt(1,4)
            contactEmail: user.profile.email || user.email
            hostInstitution: "UAB"
            participantCount: randomInt(100,5000)
            dateCreated: now - randomInt(0,96) * hour
            owner: user._id

    insertRandomCollection num for num in [0..100]

    tufayl =
        owners: [isa._id]
        members: [bob._id]
        name: "Tufayl Biospecimens"
        description: "The Tufayl Biospecimen Collection Service"
        url: "https://specimens.tufayl.com/"
    tufaylId = Organizations.insert tufayl

    example =
        owners: [admin._id, isa._id]
        members: [bob._id, kallie._id]
        name: "Example Organization"
        description: "An Example Biospecimen Collection Organization"
        url: "https://example.com"
    exampleId = Organization.insert example
