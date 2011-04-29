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

      bar.data('key', data[i].key);

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

  this.clear = function(fn) {
    list.fadeOut(function() { list.empty(); fn(); });
  };
};

Cityment.Data = function() {
  var url = "http://grepsy.cloudant.com/cityment/_design/";

  this.view = function(query, cb) {
    jQuery.ajax(url + query, { dataType: 'jsonp', success: cb});
  }
}

function keySort(key) {
  return function (a, b) {
    return key(a) < key(b) ? 1 : key(a) > key(b) ? -1 : 0;
  }
}

$(document).ready(function() {
  data = new Cityment.Data();
  bars = new Cityment.Bars();

  $('#main ul li').live('click', function() {
    var key = $(this).data('key');
    data.view('filter/_view/spatial?key="'+key+'"&include_docs=true', function(data) {
      data.rows.sort(keySort(function(r) { return r.doc.created_at.join(); }));
      bars.clear(function() {
        $('#newsitem').tmpl(data.rows).appendTo('#main');
      });
    });
  });

  data.view('aggregate/_view/area?group=true', function(data) {
    data.rows.sort(keySort(function(r) { return r.value; }));
    bars.draw(data.rows);
  });
});