class PairingSessionHandler
  attr_accessor :ids

  def initialize(ids)
    @ids = ids
  end

  def create_or_update_session
    return create_session unless session_already_exists?
    update_session
  end

  private

  def session_already_exists?
    if previous_session == nil
      return false
    else
      return previous_session.end_time > threshold
    end
  end

  def threshold
    30.seconds.ago
  end

  def update_session
    previous_session.update_attributes end_time: Time.now
  end

  def previous_session
    @previous_session ||= PairingSession.find_by_sql(crazy_sql).first
  end

  def crazy_sql
    <<-SQL
        select ps.*
        from pairing_sessions ps
        where ps.id in (
           select number_of_pairs_in_sessions.pairing_session_id
           from 
           (
              select psu.pairing_session_id, count(*) as number_pairs
              from pairing_sessions_users psu
              where psu.user_id in (#{ids.join(',')})
              group by psu.pairing_session_id
           ) number_of_pairs_in_sessions
           where number_of_pairs_in_sessions.number_pairs > 1
        )
        order by ps.end_time desc
        limit 1
    SQL
  end

  def create_session
    PairingSession.create! users: users, start_time: Time.now, end_time: Time.now
  end

  def users
    User.where id: ids
  end
end
