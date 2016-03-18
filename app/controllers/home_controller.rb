class HomeController < ApplicationController
  include ActionView::Helpers::DateHelper
  def index
    @pairing_sessions = PairingSession.eager_load(:users).map do |session|
      { users: session.users.collect(&:name),
        duration:  distance_of_time_in_words(session.end_time - session.start_time),
        start_time: session.start_time.strftime('%m/%d/%Y %H:%M:%S'),
        end_time: session.end_time.strftime('%m/%d/%Y %H:%M:%S') }
    end
  end
end
