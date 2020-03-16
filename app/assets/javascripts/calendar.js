function eventCalendar() {
  calendar = $('#calendar')
  calendar.fullCalendar({
    header: {
      left: 'prev, next, today',
      center: 'title',
      right: 'month'
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
        container: 'body',
        delay: {
          "show": 300,
          "hide": 100
        }
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
      data = { authenticity_token: $('[name="csrf-token"]')[0].content };
      $.ajax({
        url: '/events/new',
        data: data,
        type: 'GET',
        success: function () {
          $('#event_start_date').val(start.format('YYYY-MM-DD'));
          $('#event_end_date').val(end.format('YYYY-MM-DD'));
          cancel_event_button_click_listener();
        }
      });
    },

    eventDrop: function(event, delta, revertFunc) {
      data = {
        event: {
          id: event.id,
          start_date: event.start.format(),
          end_date: function() {
            if (event.end !== null){
              return event.end.format()
            }
          }
        },
        authenticity_token: $('[name="csrf-token"]')[0].content
      };
      $.ajax({
        url: '/events/' + event.id,
        data: data,
        type: 'PATCH'
      });
    },

    eventClick: function(event, jsEvent, view) {
      data = {
        event: { id: event.id, format: 'js' },
        authenticity_token: $('[name="csrf-token"]')[0].content
      };
      $.ajax({
        url: '/events/' + event.id,
        data: data,
        type: 'GET',
        success: function () {
          edit_event_button_click_listener();
          show_event_color();
          cancel_event_button_click_listener();
          color_change_listener();
          title_change_listener();
        }
      });
    }
  })
}

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
};

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
