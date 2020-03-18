function show_event_color() {
    color = $('.color').html();
    $('.modal-header').css('background-color', color);
};

function cancel_event_button_click_listener() {
  $('.cancel-event-button').on('click', function (e) {
    e.preventDefault();
    $('.modal').modal('hide');
  })
};

function edit_event_button_click_listener() {
  $('.edit-event-button').on('click', function(e) {
    e.preventDefault();
    $('.edit-form').toggleClass('hidden')
    $('.show-form').toggleClass('hidden')
  })
};

function color_change_listener() {
  $('.color-input').on('change', function() {
    color = $(this).val();
    $('.show-event-modal.modal-header').css('background-color', color);
  });
};

function title_change_listener() {
  $('.event-title-form input').on('input', function () {
    // text = $(this).val();
    $(".modal-header h1").text($(this).val());
  });
};

$(document).on('turbolinks:load', show_event_color);
$(document).on('turbolinks:load', cancel_event_button_click_listener);
$(document).on('turbolinks:load', edit_event_button_click_listener);
$(document).on('turbolinks:load', color_change_listener);
$(document).on('turbolinks:load', title_change_listener);
