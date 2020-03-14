function initializeCalendar() {
  calendar = $('#calendar')
  console.log(calendar);
  calendar.fullCalendar({
  })
}

$(document).on('turbolinks:load', function() {
  initializeCalendar()
})
