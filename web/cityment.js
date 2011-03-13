var Cityment = Cityment || {};

Cityment.Bars = function(data) {
  var SCALE = 12;

  this.draw = function() {
    var list = $('#main ul');
    list.empty();
    for (var i = 0; i < data.length; i++) {
      var bar = $('<li>'),
          label = $('<span class="label">').text(data[i].area).appendTo(bar),
          width = data[i].score * SCALE;

      list.append(bar);
      bar.css('width', Math.abs(width));
      if (width < 0) {
        bar.addClass('negative').
            css('left', width);
        label.css('left', -width);
      }
      else {
        label.css('left', -label.outerWidth());
      }
    }
  }
}

$(document).ready(function() {
  bars = new Cityment.Bars(scores);
  bars.draw();
});