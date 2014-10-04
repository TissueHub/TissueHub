hasAttributes = function (object, attributes) {
    return _.all(attributes, function (attribute) {
        return _.has(object, attribute) && object[attribute];
    });
}

getEmail = function (user) {
    if (user.profile.email) {
        return user.profile.email;
    } else if (user.emails && user.emails.length > 0) {
        return user.emails[0].address;
    } else if (user.services && user.services.google) {
        return user.services.google.email;
    } else if (user.services && user.services.github) {
        return user.services.github.email;
    }
}
