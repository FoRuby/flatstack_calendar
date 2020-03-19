function close_card() {
  $('.close-icon').on('click',function() {
    $(this).closest('.card').fadeOut();
  })
};

$(document).on('turbolinks:load', close_card);
