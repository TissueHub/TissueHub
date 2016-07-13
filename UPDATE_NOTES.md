```shell
$ meteor update
Update to release METEOR@1.3.4.4 is impossible:
While selecting package versions:
error: Conflict: Constraint stylus@1.0.0 is not satisfied by stylus 2.512.4.
Constraints on package "stylus":
* stylus@=2.512.4 <- top level
* stylus@1.0.0 <- rajit:accounts-ui-bootstrap-3 1.2.3

This project is at the latest release which is compatible with your current package constraints.
Your top-level dependencies are at their latest compatible versions.

The following top-level dependencies were not updated to the very latest version available:
 * alanning:roles 1.2.13 (1.2.15 is available)
 * aldeed:collection2 2.7.0 (2.9.1 is available)
 * aldeed:simple-schema 1.3.3 (1.5.3 is available)
 * constellation:autopublish 0.4.0 (0.4.1 is available)
 * constellation:console 1.4.0 (1.4.1 is available)
 * constellation:session 0.4.1 (0.4.2 is available)
 * constellation:subscriptions 0.4.1 (0.4.2 is available)
 * meteorhacks:kadira 2.27.3 (2.29.1 is available)
 * natestrauser:select2 3.5.1 (4.0.2 is available)
 * sanjo:jasmine 0.18.0 (1.0.1 is available)
 * velocity:console-reporter 0.1.4 (0.2.1 is available)
 * velocity:html-reporter 0.8.2 (0.10.1 is available)

Newer versions of the following indirect dependencies are available:
 * aldeed:template-extension 3.4.3 (4.0.0 is available)
 * babrahams:editable-json 0.6.3 (0.6.4 is available)
 * dburles:mongo-collection-instances 0.3.4 (0.3.5 is available)
 * lai:collection-extensions 0.1.4 (0.2.1_1 is available)
 * momentjs:moment 2.10.6 (2.14.1 is available)
 * npm-bcrypt 0.7.8_2 (0.8.7 is available)
 * sanjo:karma 1.7.0 (3.1.1 is available)
 * sanjo:meteor-files-helpers 1.1.0_7 (1.2.0_1 is available)
 * velocity:chokidar 1.0.3_1 (1.2.0_1 is available)
 * velocity:core 0.9.3 (0.10.10 is available)
To update one or more of these packages, pass their names to `meteor update`.
```
