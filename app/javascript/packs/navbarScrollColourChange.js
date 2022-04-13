$(function () {
  $(document).scroll(function () {
    var $nav = $(".navbar");
    $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
    $nav.toggleClass('navbar-dark', $(this).scrollTop() > $nav.height());
  });
});
