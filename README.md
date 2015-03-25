# TissueHub

[Main Site][1] | [Development][2] | [![Build Status](https://travis-ci.org/TissueHub/TissueHub.svg?branch=master)](https://travis-ci.org/TissueHub/TissueHub)

TissueHub aspires to be a socially federated storefront for biospecimen repositories of all sizes.

The ultimate vision of TissueHub is the creation of a biospecimen resource with three core constituencies: managers of large biospecimen collections, investigators, and patients (donors). Borrowing the federated storefront model of, e.g., Amazon and extending it with social networking features, the federated biorepositories will serve as a “TissueHub”. This TissueHub will enable the holders of biospecimens to publish their collections and services. Investigators can use TissueHub to discover available specimens as well as opportunities for collaboration with others holding overlapping rare-specimen collections. Finally, TissueHub will allow donors to discover opportunities to contribute to scientific studies, as well as to see the research data and publications derived from these contributions.

## Development

The initial prototype of TissueHub is under development as a [Meteor](https://www.meteor.com/ "Meteor Homepage") app. To start, first install meteor, then:

```
git clone https://github.com/TissueHub/TissueHub.git
cd TissueHub
meteor
```

### Building

1. Ensure the `VERSION` environment variable in .travis.yml is correct.
2. Kick off the build using `make`

    ```shell
    $ make build
    ```

3. Find the built app as `.build/tissuehub.tar.gz`.

### Deployment

1. [Build TissueHub](#Building)
2. Copy `.build/tissuehub.tar.gz` to the desired location and unpack it.
3. Install npm dependencies

    ```shell
    $ cd tissuehub/bundle/programs/server
    $ npm install
    ```

4. Start the server

    ```shell
    $ cc ../.. # to tissuehub/bundle
    $ node main.js
    ```

### Useful Environment Variables

* `PORT=3001`
* `MONGO_URL=mongodb://localhost/TissueHub`
* `MONGO_OPLOG_URL=mongodb://localhost/local`
* `ROOT_URL="https://tissuehub.org/"`

These can be set in the environment, or just prepended to the `node main.js` command:

```shell
$ PORT=3001 MONGO_URL=mongodb://localhost/TissueHub MONGO_OPLOG_URL=mongodb://localhost/local ROOT_URL="https://tissuehub.org/" node main.js
```

[1]: https://tissuehub.org/ "TissueHub App"
[2]: http://tissuehub.meteor.com/ "TissueHub Development Site"
[3]: https://travis-ci.org/TissueHub/TissueHub "TissueHub Continuous Integration at Travis-CI"