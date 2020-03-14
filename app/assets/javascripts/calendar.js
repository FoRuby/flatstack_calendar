function initializeCalendar() {
  calendar = $('#calendar')
  console.log(calendar);
  calendar.fullCalendar({
    header: {
      left: 'prev, next, today',
      center: 'title',
      right: 'month, listMonth'
    },

    eventRender: function(event, eventElement) {
      eventElement.attr('id', 'event-' + event.id);
    },

    selectable: true,
    selectHelper: true,
    editable: true,
    eventLimit: true,
    events: '/events.json',

    eventDrop: function(event, delta, revertFunc) {
      data = {
        event: {
          id: event.id,
          start_date: event.start.format(),
          end_date: event.end.format()
        },
        authenticity_token: $('[name="csrf-token"]')[0].content
      };
      $.ajax({
        url: event.update_url,
        data: data,
        type: 'PATCH',
        success: function() {
          flash_fade_out();
        }
      });

    },
  })
}

$(document).on('turbolinks:load', function() {
  initializeCalendar()
})
