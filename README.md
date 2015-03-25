# TissueHub

[Main Site](https://tissuehub.org/ "TissueHub App") | [Development](http://tissuehub.meteor.com/ "TissueHub Development Site")

TissueHub aspires to be a socially federated storefront for biospecimen repositories of all sizes.

The ultimate vision of TissueHub is the creation of a biospecimen resource with three core constituencies: managers of large biospecimen collections, investigators, and patients (donors). Borrowing the federated storefront model of, e.g., Amazon and extending it with social networking features, the federated biorepositories will serve as a “TissueHub”. This TissueHub will enable the holders of biospecimens to publish their collections and services. Investigators can use TissueHub to discover available specimens as well as opportunities for collaboration with others holding overlapping rare-specimen collections. Finally, TissueHub will allow donors to discover opportunities to contribute to scientific studies, as well as to see the research data and publications derived from these contributions.

## Development

The initial prototype of TissueHub is under development as a [Meteor](https://www.meteor.com/ "Meteor Homepage") app. To start, first install meteor, then:

```
git clone https://github.com/TissueHub/TissueHub.git
cd TissueHub
meteor
```

## Deployment

Build (produces a `builds/build-<timestamp>`)

```shell
$ make build
```

Starting the App (test)

PORT=3001 MONGO_URL=mongodb://localhost/TissueHub MONGO_OPLOG_URL=mongodb://localhost/local ROOT_URL="https://tissuehub.org/"

