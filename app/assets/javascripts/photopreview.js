$(document).ready(function() {
  if ($('.photo-preview').length) {
    $('#page_flickr_photo_id').bind('input', function() {
      setPreviewImage($(this).val());
    });
  }
});

var setPreviewImage = function(photoId) {
  $.getJSON('/photo/' + (photoId || 1))
    .done(function(response) {
      var photo_url = response.photo_url;
      if (photo_url) { fillPhotoPreview(photo_url); }
      else { clearPhotoPreview(); }
    })
    .fail(function(response) {
      clearPhotoPreview();
  });
}

var fillPhotoPreview = function(imgUrl) {
  var imgTag = '<img src="' + imgUrl + '">'
  $('.photo-preview').html(imgTag);
}

var clearPhotoPreview = function() {
  $('.photo-preview').empty();
}
