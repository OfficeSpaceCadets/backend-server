class PairingSessionHandler
  attr_accessor :ids

  def initialize(ids)
    @ids = ids
  end

  def create_or_update_session
    PairingSession.create! users: users, start_time: Time.now, end_time: Time.now
  end

  private

  def users
    User.where id: ids
  end
end
