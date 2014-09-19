if Collections.find().count() is 0
    now = new Date().getTime()
    hour = 1000 * 60 * 60 # ms * sec * min
    day = 24 * hour
    week = 7 * day
    base = now - 10 * hour # base creation time for fixture elements

    # Users
    kallieId = Accounts.createUser
        profile:
            name: "Kallie Emil"
        username: "kallie"
        password: "password"

    isaId = Accounts.createUser
        profile:
            name: "Isa Tufayl"
        username: "isa"
        password: "password"

    adminId = Accounts.createUser #Create admin login
        profile:
            name: "Admin"
        username: "admin"
        password: "password"

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
            owner: kallieId
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
            owner: kallieId
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
            owner: isaId
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
            owner: isaId
