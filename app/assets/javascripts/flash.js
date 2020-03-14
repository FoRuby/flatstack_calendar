function flash_fade_out() {
  setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $('.alert').remove();
      });
  }, 5000);
}
