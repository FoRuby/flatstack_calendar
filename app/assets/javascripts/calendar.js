function eventCalendar() {
  calendar = $('#calendar')
  calendar.fullCalendar({
    header: {
      left: 'prev, next, today',
      center: 'title',
      right: 'month, listMonth'
      // right: 'month, listMonth, timeGridFourDay'
    },

    // views: {
    //   timeGridFourDay: {
    //     type: 'listMonth',
    //     duration: { days: 4 },
    //     buttonText: '4 day',
    //     selectable: true,
    //     editable: true,
    //     eventLimit: true
    //   }
    // },

    eventRender: function(eventObj, $el) {
      $el.popover({
        title: eventObj.title,
        content: eventObj.description,
        background: eventObj.color,
        trigger: 'hover',
        placement: 'top',
        container: 'body'
      });
    },

    eventAfterRender: function(event ,element) {
      element.attr('id', 'event-' + event.id);
      flash_handler();
    },

    selectable: true,
    selectHelper: true,
    editable: true,
    eventLimit: true,
    events: '/events.json',

    select: function(start, end) {
      $.getScript('/events/new', function() {
        $('#event_start_date').val(start.format('YYYY-MM-DD'));
        $('#event_end_date').val(end.format('YYYY-MM-DD'));
      });
      calendar.fullCalendar('unselect');
    },

    eventDrop: function(event, delta, revertFunc) {
      data = {
        event: {
          id: event.id,
          start_date: event.start.format(),
          end_date: function() {
            if (event.end !== null){
              return event.start.format()
            }
          }
        },
        authenticity_token: $('[name="csrf-token"]')[0].content
      };
      $.ajax({
        url: event.update_url,
        data: data,
        type: 'PATCH'
      });

    },
  })
}

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
};

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
