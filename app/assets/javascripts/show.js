const show_event_color = () => {
  let color = $('.color').html();
  $('.show-event-modal .modal-header').css('background-color', color);
};

const cancel_event_button_click_listener = () => {
  $('.cancel-event-button').on('click', e => {
    e.preventDefault();
    $('.card').remove();
    clear_form();
    $('.modal').modal('hide');
  });
};

const clear_form = () => {
  $('.event-title input').val('');
  $('.event-description textarea').val('');
  $('.event-color input').val('#000000');
  $('.modal-header').css('background-color', '#ffffff');
};

const edit_event_button_click_listener = () => {
  $('.edit-event-button').on('click', e => {
    e.preventDefault();
    $('.edit-form').toggleClass('hidden');
    $('.show-form').toggleClass('hidden');
  });
};

const color_change_listener = () => {
  $('.event-color input').on('change', function() {
    let color = $(this).val();
    $('.show-event-modal .modal-header').css('background-color', color);
  });
};

const title_change_listener = () => {
  $('.event-title input').on('input', function() {
    $(".modal-header h1").text($(this).val());
  });
};

$(document).on('turbolinks:load', () => {
  show_event_color;
  cancel_event_button_click_listener;
  edit_event_button_click_listener;
  color_change_listener;
  title_change_listener;
});
