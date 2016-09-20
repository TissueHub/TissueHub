
var TabularTables;

TabularTables = {};

if (Meteor.isClient) {
  Template.registerHelper("TabularTables", TabularTables);
}

TabularTables.Specimens = new Tabular.Table({
  name: "SpecimenList",
  collection: Specimens,
  columns: [
    {
      data: "localId",
      title: "Local ID"
    }, {
      data: "type",
      title: "Type"
    }, {
      data: "phenotype",
      title: "Phenotype"
    }, {
      data: "ethnicity",
      title: "Ethnicity"
    }, {
      data: "pathalogicalDiagnosis",
      title: "Pathalogical Diagnosis"
    }, {
      tmpl: Meteor.isClient && Template.specimenbuttoncell
    }
  ]
});
