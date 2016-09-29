// Generated by CoffeeScript 1.10.0
Template.addspecimenbulk.helpers({
  "afterParseHandler": function() {
    var collectionId;
    collectionId = this.collection._id;
    return function() {
      this.parsedData.meta.fields.push("partOf");
      return this.parsedData.data.forEach(function(row) {
        row.partOf = [collectionId];
        return row.outcomes = [row.outcomes];
      });
    };
  }
});