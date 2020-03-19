function show_event_color() {
    color = $('.color').html();
    $('.show-event-modal .modal-header').css('background-color', color);
};

function cancel_event_button_click_listener() {
  $('.cancel-event-button').on('click', function (e) {
    e.preventDefault();
    $('.card').remove();
    clear_form();
    $('.modal').modal('hide');
  })
};

function clear_form() {
  $('#event_title').val('');
  $('#event_description').val('');
  $('#event_color').val('#000000');
  $('.modal-header').css('background-color', '#ffffff');

}

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
    $('.show-event-modal .modal-header').css('background-color', color);
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

function test() {
  $('.test').on('click', function(e) {
    e.preventDefault();
    // $('.new-event-modal').modal('toggle');
    $('.flash-messages').append( "<strong>Hello</strong>" );
  })
};

$(document).on('turbolinks:load', test);
