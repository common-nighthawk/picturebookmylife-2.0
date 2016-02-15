$(document).ready(function() {
  $('#page-sort').sortable({
    axis: 'y',
    update: function(event, ui) {
      $.post('/positions', $(this).sortable('serialize'));
    }
  });
});
