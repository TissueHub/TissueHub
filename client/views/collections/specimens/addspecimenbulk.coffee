Template.addspecimenbulk.helpers
    "afterParseHandler": ->
        collectionId = @collection._id
        return () ->
            @parsedData.meta.fields.push "partOf"
            @parsedData.data.forEach (row) ->
                row.partOf = [collectionId]
                row.outcomes = [row.outcomes]