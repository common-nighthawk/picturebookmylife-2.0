$(document).ready(function() {
  if ($('.photo-carousel').length) {
    setPhotoHeight();
  }
});

$(document).on('page:load', function() {
  if ($('.photo-carousel').length) {
    setPhotoHeight();
  }
});

$(window).resize(function() {
  if ($('.photo-carousel').length) {
    setPhotoHeight();
  }
});

var setPhotoHeight = function() {
  var windowHeight = $(window).height();
  var takenHeight = $('nav').outerHeight(true) + $('.page-text').outerHeight(true);
  var bottomMargin = 30;
  var photoHeight = windowHeight - takenHeight - bottomMargin;
  $('img').css('max-height', photoHeight);
}
