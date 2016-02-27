class HomeController < ApplicationController
  def index
    @pairing_sessions = PairingSession.eager_load(:users).map do |session|
      { users: session.users.collect(&:name), 
        start_time: session.start_time.strftime('%m/%d/%Y %H:%M:%S'),
        end_time: session.end_time.strftime('%m/%d/%Y %H:%M:%S') }
    end
  end
end
