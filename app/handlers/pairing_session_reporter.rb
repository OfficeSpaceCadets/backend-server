class PairingSessionReporter
  include ActionView::Helpers::DateHelper

  def todays_pairs
    PairingSession.eager_load(:users).map do |session|
      transform_data session
    end
  end

  def latest_pairs
    transform_data PairingSession.eager_load(:users).last
  end

  private

  def transform_data(session)
    { 
      users: session.users.collect do |user|
        { 
          external_id: user.external_id,
          name: user.name
        }
      end,
      pair_clock: Time.diff(session.start_time, session.end_time)[:diff],
      duration:  distance_of_time_in_words(session.end_time - session.start_time),
      start_time: session.start_time.strftime('%m/%d/%Y %H:%M:%S'),
      end_time: session.end_time.strftime('%m/%d/%Y %H:%M:%S') 
    }
  end
end
