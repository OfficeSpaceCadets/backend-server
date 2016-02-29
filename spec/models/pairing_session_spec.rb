require 'rails_helper'

RSpec.describe PairingSession do
  it { should have_and_belong_to_many(:users) }
  it { should have_db_column(:start_time).of_type(:datetime) }
  it { should have_db_column(:end_time).of_type(:datetime) }

  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let!(:user3) { create :user }

  describe '!last_session_for' do
    context 'only one session exists for the two users' do
      it 'should return that session' do    
        expected_session = create :pairing_session, users: [user1, user2]

        last_session = PairingSession.last_session_for [user1.id, user2.id]

        expect(last_session.id).to eq(expected_session.id)
      end
    end

    context 'multiple sessions exists but only one for the two users' do
      it 'should return that session' do    
        create :pairing_session, users: [user1, user3]
        create :pairing_session, users: [user3, user1]
        expected_session = create :pairing_session, users: [user1, user2]
        create :pairing_session, users: [user2, user3]
        create :pairing_session, users: [user3, user2]
        create :pairing_session, users: [user1]
        create :pairing_session, users: [user2]

        last_session = PairingSession.last_session_for [user1.id, user2.id]

        expect(last_session.id).to eq(expected_session.id)
      end
    end

    context 'multiple sessions with the two users' do
      it 'should return that session' do    
        Timecop.freeze 20.minutes.ago do
          create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now
        end
        Timecop.freeze 15.minutes.ago do
          create :pairing_session, users: [user2, user1], start_time: Time.now, end_time: Time.now
        end
        Timecop.freeze 10.minutes.ago do
          create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now
        end
        Timecop.freeze 2.minutes.ago do
          create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now
        end
        Timecop.freeze 1.minute.ago do
          create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now
        end
        expected_session = create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now

        last_session = PairingSession.last_session_for [user1.id, user2.id]

        expect(last_session.id).to eq(expected_session.id)
      end
    end

    context 'multiple sessions with the multipl users' do
      it 'should return that session' do    
        session1 = nil
        session2 = nil
        session3 = nil
        session4 = nil

        Timecop.freeze 20.minutes.ago do
          session1 = create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now
        end
        Timecop.freeze 15.minutes.ago do
          session2 = create :pairing_session, users: [user2, user3], start_time: Time.now, end_time: Time.now
        end
        Timecop.freeze 10.minutes.ago do
          session3 = create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now
        end
        Timecop.freeze 2.minutes.ago do
          session4 = create :pairing_session, users: [user3, user1], start_time: Time.now, end_time: Time.now
        end
        session5 = create :pairing_session, users: [user1, user2], start_time: Time.now, end_time: Time.now

        expect(PairingSession.last_session_for([user1.id, user2.id]).id).to eq(session5.id)
        expect(PairingSession.last_session_for([user2.id, user1.id]).id).to eq(session5.id)
        expect(PairingSession.last_session_for([user2.id, user3.id]).id).to eq(session2.id)
        expect(PairingSession.last_session_for([user3.id, user2.id]).id).to eq(session2.id)
        expect(PairingSession.last_session_for([user3.id, user1.id]).id).to eq(session4.id)
        expect(PairingSession.last_session_for([user1.id, user3.id]).id).to eq(session4.id)
      end
    end
  end
end
