window.formatDateString = function(date) {
  date = date || this.date;
  if (date) {
    return moment(date).format(Session.get("momentDateFormat"));
  }
};

Template.registerHelper("formatDateString", window.formatDateString);
