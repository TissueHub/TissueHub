# TissueHub Permissions Model

## Terminology

* A **document** represents any data entity: collection, specimen, etc.

* **Actions** are things that _actors_ may perform on _documents_:
    - Create
    - Read
    - Update
    - Delete
    - Manage (modify permissions, ownership, etc.)
* **Actors** are individuals or groups that may perform _actions_ on _documents_:
    - Users (by Id)
    - Organizations (by Id)
    - All authenticated users `authenticated`
    - The general public `public`
* Documents can **Inherit** some or all of their permissions from a higher level document. E.g. a specimen can inherit its permissions from its collection.
* Granting permissions, as described below, refers to whether TissueHub will permit an _action_ for a given _actor_. This does not necessarily mean that the default set of permissions will be empty, but that any default permissions will be explicitly identified in the document's permissions element.

## Format

* The current `owner` of a `document` has all permissions for that document.
* A `document` has a `permissions` element.
    
    ```json
    {
        _id: "ab12cd34",
        owner: "ef56gh78",
        permissions: {...},
        ...
    }
    ```
    If this element does not exist, no permissions are granted.

* The `permissions` element is an object with action keys and actor values.

    ```json
    permissions: {
        read: ["all"],
        update: ["ef56gh78"]
    }
    ```
    Only explicitly identified permissions are granted.
* Actor values in the permissions element can also specify the individual fields on the document to which the permission applies.

    ```json
    permissions: {
        read: [["ef56gh78","name","description","participantCount"]]
    }
    ```
    If no field specifiers are added, the permission applies to the entire document (minus protected fields such as `permissions`).