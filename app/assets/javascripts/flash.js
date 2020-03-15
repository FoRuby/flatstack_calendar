function flash_handler() {
 setTimeout(function() {
     $(".alert").fadeTo(400, 0).slideUp(400, function(){
       $('.alert').remove();
     });
 }, 5000);
};
