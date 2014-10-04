Template.editprofile.helpers
    raw: -> JSON.stringify @, null, 2
    email: -> getEmail(@)

Template.editprofile.events
    "submit form": (e) ->
        e.preventDefault()
        userId = Meteor.userId()
        profile =
            name: $(e.target).find("[name=name]").val()
            email: $(e.target).find("[name=email]").val()
        Meteor.users.update userId, {$set: profile: profile}, (error) ->
            if error then Alert.add error.message, "danger"
            else
                Alert.add "Profile Edited", "success"
                Router.go "viewProfile"
