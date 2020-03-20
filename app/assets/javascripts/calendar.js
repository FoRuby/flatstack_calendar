var eventCalendar = function() {
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
    eventSources: [
      '/calendar/simple_events.json',
      '/calendar/recurring_events.json'
    ],

    select: function(start, end) {
      $('.new-event-modal').modal('show');

      // 4 SimpleEventForm
      $('#event_date').val(start.format('YYYY-MM-DD'));
      $('#event_duration').val(end.diff(start, 'days'));

      // 4 RecurringEventForm
      $('#event_start_date').val(start.format('YYYY-MM-DD'));
      $('#event_end_date').val(end.format('YYYY-MM-DD'));
    },

    eventDrop: function(event, delta, revertFunc) {
      data = {
        event: {
          id: event.id,
          date: event.start.format(),
          start_date: event.start.format(),
          end_date: event.end.format()
        },
        authenticity_token: $('[name="csrf-token"]')[0].content
      };

      $.ajax({
        type: 'patch',
        url: event.path,
        data:  data,
        success: function(data) {},
        error: function(data) {}
      });
    },

    dayClick: function(start) {
      $('.new-event-modal').modal();
      // 4 SimpleEventForm
      $('#event_date').val(start.format('YYYY-MM-DD'));
      $('#event_duration').val('1');
    },

    eventClick: function(event, jsEvent, view) {
      data = {
        event: {
          id: event.id,
          start_date: event.start.format(),
          format: 'js'
        }
      };
      $.ajax({
        type: 'GET',
        contentType: 'application/json',
        url: event.path,
        data: data,
        success: function(data) {
          edit_event_button_click_listener();
          show_event_color();
          cancel_event_button_click_listener();
          color_change_listener();
          title_change_listener();
        },
        error: function(data) {}
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
