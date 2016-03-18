(function() {
  fetch_latest_session();
  setInterval(fetch_latest_session, 5000);

  function fetch_latest_session() {
    $.getJSON('/api/latest_session').done(populate_pairing_data);
  }

  function populate_pairing_data(data) {
    $('.latest_session .users').empty();
    $.each(data['users'], function(index, user) {
      var user_data = user.name;
      $('.latest_session .users').append(user_data);
    });

    $('.latest_session .duration').empty().append(data['duration']);
    $('.latest_session .start_time').empty().append(data['start_time']);
  }
})();
