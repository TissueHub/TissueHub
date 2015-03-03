@Help =
    loginUser: (user, done) ->
        Meteor.loginWithPassword user.email, user.password, done
    loginIsa: (done) ->
        Help.loginUser Users["Isa Tufayl"], done  
    loginAdmin: (done) ->
        Help.loginUser Users["Admin"], done
    logout: (done) ->
        Meteor.logout done
    data:
        users: Users
    

Users =
    "New User 1":
        email: "newuser1@example.com"
        password: "password"
    "Isa Tufayl":
        profile:
            name: "Isa Tufayl"
        email: "isa@tufayl.com"
        username: "isa"
        password: "password"
    "Admin":
        profile:
            name: "Admin"
        email: "admin@example.com"
        username: "admin"
        password: "password"