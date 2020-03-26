eventCalendar = function() {
  calendar = $('#calendar')
  calendar.fullCalendar({
    header: {
      left: 'prev, next, today',
      center: 'title',
      right: 'month_public, month_private'
    },

    views: {
      month_public: {
        type: 'month',
        buttonText: 'Public Events'
      },
      month_private: {
        type: 'month',
        buttonText: 'My Events',
      }
    },


    selectable: true,
    selectHelper: true,
    editable: false,
    eventLimit: true,
    defaultView: 'month_public',
    eventSources: [
      '/calendar/simple_events.json',
      '/calendar/recurring_events.json',
    ],
    viewRender: view_render,

    eventRender: event_render,

    eventAfterRender: event_after_render,

    select: select,

    dayClick: day_click,

    eventClick: event_click,
  })
};

select = function(start, end) {
  $('.new-event-modal').modal('show');

  // 4 SimpleEventForm
  $('#event_date').val(start.format('YYYY-MM-DD'));
  $('#event_duration').val(end.diff(start, 'days'));

  // 4 RecurringEventForm
  $('#event_start_date').val(start.format('YYYY-MM-DD'));
  $('#event_end_date').val(end.format('YYYY-MM-DD'));
}

event_click = function(event, jsEvent, view) {
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
};

day_click = function(start) {
  clear_form();
  $('.new-event-modal').modal();
  // 4 SimpleEventForm
  $('#event_date').val(start.format('YYYY-MM-DD'));
  $('#event_duration').val('1');
}

view_render = function(view) {
  // костыль с куками
  previous_view = localStorage.getItem('previous_view') || view.name
  localStorage.setItem('previous_view', previous_view);

  // Public Events => My Events
  if(view.name == 'month_private' && localStorage.getItem('previous_view') !== 'month_private') {
    calendar.fullCalendar('removeEventSource', '/calendar/simple_events.json');
    calendar.fullCalendar('removeEventSource', '/calendar/recurring_events.json');
    calendar.fullCalendar('removeEvents');
    calendar.fullCalendar('addEventSource', '/calendar/user_recurring_events.json');
    calendar.fullCalendar('addEventSource', '/calendar/user_simple_events.json');
   };

   // My Events => Public Events
  if(view.name == 'month_public' && localStorage.getItem('previous_view') !== 'month_public') {
    calendar.fullCalendar('removeEventSource', '/calendar/user_recurring_events.json');
    calendar.fullCalendar('removeEventSource', '/calendar/user_simple_events.json');
    calendar.fullCalendar('removeEvents');
    calendar.fullCalendar('addEventSource', '/calendar/simple_events.json');
    calendar.fullCalendar('addEventSource', '/calendar/recurring_events.json');
   };

   localStorage.setItem('previous_view', view.name);
}

event_render = function(eventObj, $el) {
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
}

event_after_render = function(event ,element) {
  element.attr('id', 'event-' + event.id);
  element.addClass('hoverable');
  flash_handler();
}

function clearCalendar() {
  $('#calendar').html('');
};

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
