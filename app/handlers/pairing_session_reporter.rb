class PairingSessionReporter
  include ActionView::Helpers::DateHelper

  def latest
    session = PairingSession.eager_load(:users).last
    { 
      users: session.users.collect(&:name),
      duration:  distance_of_time_in_words(session.end_time - session.start_time),
      start_time: session.start_time.strftime('%m/%d/%Y %H:%M:%S'),
      end_time: session.end_time.strftime('%m/%d/%Y %H:%M:%S') 
    }
  end
end