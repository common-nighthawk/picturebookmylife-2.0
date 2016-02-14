$(document).ready(function() {
  $('#page-sort').sortable({
    axis: 'y',
    update: function() {
      $.post('/positions', $(this).sortable('serialize'));
    }
  });
});
