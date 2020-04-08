const flash_handler = () => {
  setTimeout(() => {
    $('.alert').fadeTo(400, 0).slideUp(400, () => {
      $('.alert').remove();
    });
  }, 5000);
};

$(document).on('turbolinks:load', flash_handler);
