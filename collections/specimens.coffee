@Specimens = Specimens = new Mongo.Collection "specimens"

Specimens.allow
    insert: canEditSpecimen
    update: canEditSpecimen

Specimens.attachSchema new SimpleSchema
    localId:
        type: String
        label: "Local ID"
    partOf:
        type: String
        label: "Collection Part Of"
    type:
        type: String
        label: "Specimen Type"
        optional: true
    phenotype:
        type: String
        label: "Phenotype"
        optional: true
    ethnicity:
        type: String
        label: "Race/Ethnicity"
        optional: true
    "procedure.date":
        type: Date
        label: "Procedure Date"
        optional: true
    "procedure.type":
        type: String
        label: "Procedure Type"
        optional: true
    description:
        type: String
        label: "Description"
        optional: true
    outcomes:
        type: [String]
        label: "Outcomes"
        optional: true
    pathalogicalDiagnosis:
        type: String
        label: "Pathological Diagnosis"
        optional: true