class PairingSession < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.last_session_for(user_ids)
    find_by_sql(crazy_sql user_ids).first
  end

  private 

  def self.crazy_sql(user_ids)
    <<-SQL
        select ps.*
        from pairing_sessions ps
        where ps.id in (
           select number_of_pairs_in_sessions.pairing_session_id
           from 
           (
              select psu.pairing_session_id, count(*) as number_pairs
              from pairing_sessions_users psu
              where psu.user_id in (#{user_ids.join(',')})
              group by psu.pairing_session_id
           ) number_of_pairs_in_sessions
           where number_of_pairs_in_sessions.number_pairs > 0
        )
        order by ps.end_time desc
        limit 1
    SQL
  end
end

