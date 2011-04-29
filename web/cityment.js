var Cityment = Cityment || {};

Cityment.Bars = function() {
  var SCALE = 6;
  var list = $('#main ul');

  this.draw = function(data) {
    list.empty();
    for (var i = 0; i < data.length; i++) {
      var bar = $('<li>'),
          label = $('<span class="label">').text(data[i].key).appendTo(bar),
          score = $('<span class="score">').text(Math.round(data[i].value*100)/100),
          width = data[i].value * SCALE;

      list.append(bar);
      bar.css('width', Math.abs(width));
      if (width < 0) {
        score.appendTo(label);
        bar.addClass('negative')
           .css('left', width);
        label.css('left', -width);
      }
      else {
        score.prependTo(label);
        bar.addClass('positive');
        label.css('left', -label.outerWidth());
      }
    }
  };

  this.clear = function() {
    $('li', list).each(function() {
      var bar = $(this);
      $('.label', bar).hide('fast');
      bar.animate({ width: 0, left: 0 }, 500, function() {
        list.empty();
      });
    });
  };
};

Cityment.Data = function() {
    var url = "http://grepsy.cloudant.com/cityment/_design/aggregate/_view/area?group=true";

    this.perArea = function(cb) {
        jQuery.ajax(url, { dataType: 'jsonp', success: cb});
    }
}

$(document).ready(function() {
  data = new Cityment.Data();
  bars = new Cityment.Bars();
  data.perArea(function(data) {
      data.rows.sort(function(a,b){
        return a.value < b.value ? 1 : a.value > b.value ? -1 : 0;
      });
      bars.draw(data.rows);
  });
});