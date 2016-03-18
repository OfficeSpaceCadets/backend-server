(function() {
  fetch_latest_session();
  setInterval(fetch_latest_session, 5000);

  function fetch_latest_session() {
    $.getJSON('/api/latest_session').done(populate_pairing_data);
  }

  function populate_pairing_data(data) {
    $('.pair-clock').empty().append(data['pair_clock']);
    $('.photos .photo:first img').attr('src', '/images/' + data['users'][0]['external_id'] + '.jpg');
    $('.photos .photo:first figcaption').empty().append(data['users'][0]['name']);
    $('.photos .photo:last img').attr('src', '/images/' + data['users'][1]['external_id'] + '.jpg');
    $('.photos .photo:last figcaption').empty().append(data['users'][1]['name']);

    $('.latest_session .duration').empty().append(data['duration']);
    $('.latest_session .start_time').empty().append(data['start_time']);
    clock_timer = setInterval(update_clock(data['start_time']), 1000);
  }

  function update_clock(start_time) {
    var now = new Date();
    var countFrom = new Date(start_time);
    var difference = now - countFrom;

    var days=Math.floor(difference/(60*60*1000*24)*1);
    var hours=Math.floor((difference%(60*60*1000*24))/(60*60*1000)*1);
    var mins=Math.floor(((difference%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
    var secs=Math.floor((((difference%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

    var output = hours + ':' + pad(mins) + ':' + pad(secs);
    $('.pair-clock').empty().append(output);
  }

  function pad(val)
    {
      var valString = val + "";
      if(valString.length < 2)
      {
        return "0" + valString;
      }
      else
      {
        return valString;
      }
    }
})();
