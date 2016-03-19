(function() {
  fetch_latest_session();
  setInterval(fetch_latest_session, 1000);

  function fetch_latest_session() {
    $.getJSON('/api/latest_session').done(populate_pairing_data);
  }

  function populate_pairing_data(data) {
    console.log("Users: ", data['users']);
    $('.pair-clock').empty().append(data['pair_clock']);
    if (data['users'][0]) {
      $('.photos .photo:first img').attr('src', '/images/' + data['users'][0]['external_id'] + '.jpg');
      $('.photos .photo:first figcaption').empty().append(data['users'][0]['name']);
      $('.photos .photo:first').removeClass('inactive');
    } else {
      $('.photos .photo:first').addClass('inactive');
    }

    if (data['users'][1]) {
      $('.photos .photo:last img').attr('src', '/images/' + data['users'][1]['external_id'] + '.jpg');
      $('.photos .photo:last figcaption').empty().append(data['users'][1]['name']);
      $('.photos .photo:last').removeClass('inactive');
    } else {
      $('.photos .photo:last').addClass('inactive');
    }

    $('.latest_session .duration').empty().append(data['duration']);
    $('.latest_session .start_time').empty().append(data['start_time']);
    $('.pair-clock').empty().append(data['pair_clock']);
  }
})();
