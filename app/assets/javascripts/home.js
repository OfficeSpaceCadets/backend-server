(function() {
  fetch_todays_sessions();
  setInterval(fetch_todays_sessions, 5000);

  function fetch_todays_sessions() {
    $.getJSON('/api/todays_sessions').done(populate_todays_sessions);
  }

  function populate_todays_sessions(data) {
    $('#pairing_sessions_table').empty();

    $.each(data, function(index, pairing_session) {
      create_new_row(pairing_session);
    });
  }

  function create_new_row(pairing_session) {
    $('#pairing_sessions_table').append($('#pairing_session_template').html());

    var last_row = $('#pairing_sessions_table tr:last');
    last_row.find('.user:first').append(pairing_session['users'][0]['name']);
    last_row.find('.user:last').append(pairing_session['users'][1]['name']);
    last_row.find('.time:first').append(pairing_session['start_time']);
    last_row.find('.time:last').append(pairing_session['end_time']);
    last_row.find('.duration').append(pairing_session['duration']);
  }
})();
