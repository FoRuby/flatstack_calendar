function eventCalendar() {
  $('#calendar').fullCalendar({
  });
};

$(document).on('turbolinks:load', function() {
  eventCalendar();
});
