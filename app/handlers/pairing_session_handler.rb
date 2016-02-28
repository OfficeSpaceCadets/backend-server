class PairingSessionHandler
  attr_reader :user_ids

  def initialize(user_ids)
    @user_ids = user_ids
  end

  def create_or_update_session
    return create_session unless session_already_exists?
    update_session
  end

  private

  def session_already_exists?
    previous_session != nil and previous_session.end_time > threshold
  end

  def threshold
    30.seconds.ago
  end

  def update_session
    previous_session.update_attributes end_time: Time.now
  end

  def previous_session
    @previous_session ||= PairingSession.last_session_for user_ids
  end

  def create_session
    PairingSession.create! users: users, start_time: Time.now, end_time: Time.now
  end

  def users
    User.where id: user_ids
  end
end
