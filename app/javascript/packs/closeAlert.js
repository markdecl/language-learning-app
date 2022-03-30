// Automatically close alerts after 5 seconds
// setTimeout(function () {
//   // Closing the alert
//   $('.alert').alert('close');
// }, 5000);

window.setTimeout(function () {
  $(".alert").fadeTo(1000, 0).slideUp(500, function () {
    $(this).remove();
  });
}, 2000);
