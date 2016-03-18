require 'rails_helper'

RSpec.describe PairingSessionHandler do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let!(:user3) { create :user }
  let(:user_ids) { [user1.id, user2.id] }
  let(:user_external_ids) { [user1.external_id, user2.external_id] }
  let!(:current_time) { Time.now }

  subject { described_class.new user_external_ids }
  
  shared_examples 'created a new valid session' do
    it 'should create a session that contains the users' do
      actual_user_ids = pairing_session.users.pluck :id
      
      expect(actual_user_ids).to eq(user_ids)
    end

    it 'should create session with a current start time' do
      expect(pairing_session.start_time.to_i).to eq(current_time.to_i)
    end

    it 'should create session with a the same end time as the start time' do
      expect(pairing_session.start_time).to eq(pairing_session.end_time)
    end
  end

  describe '#create_or_update_session' do
    context 'no previous session exists' do
      let(:pairing_session) { PairingSession.first }

      before do
        Timecop.freeze current_time
        subject.create_or_update_session
      end

      after do
        Timecop.return
      end

      it 'should create the session' do
        expect(PairingSession.count).to be(1)
      end

      it_behaves_like 'created a new valid session'
    end

    context 'previous session exists but was a while ago' do
      let(:pairing_session) { PairingSession.last }
      
      before do
        Timecop.freeze(current_time - threshold) do
          subject.create_or_update_session
        end

        Timecop.freeze current_time
        subject.create_or_update_session
      end

      after do
        Timecop.return
      end
      
      it 'should create a second session' do
        expect(PairingSession.count).to be(2)
      end

      it_behaves_like 'created a new valid session'
    end

    context 'previous session exists only a few seconds ago but with different users' do
      let(:pairing_session) { PairingSession.last }
      
      before do
        Timecop.freeze current_time

        described_class.new([user1.external_id, user3.external_id]).create_or_update_session
        subject.create_or_update_session
      end

      after do
        Timecop.return
      end
      
      it 'should create two sessions' do
        expect(PairingSession.count).to be(2)
      end

      it_behaves_like 'created a new valid session'
    end

    context 'previous session exists only a few seconds ago' do
      let(:pairing_session) { PairingSession.first }
      
      before do
        Timecop.freeze(twenty_nine_seconds_ago) do
          subject.create_or_update_session
        end

        Timecop.freeze current_time
        subject.create_or_update_session
      end

      after do
        Timecop.return
      end
      
      it 'should only create a single session' do
        expect(PairingSession.count).to be(1)
      end

      it 'should update the end_time to be the current time' do
        expect(pairing_session.start_time.to_i).to_not be(pairing_session.end_time.to_i)
      end

      it 'should still have the same start time' do
        expect(pairing_session.start_time.to_i).to be(twenty_nine_seconds_ago.to_i)
      end

      def twenty_nine_seconds_ago
        current_time - (threshold - 1.second)
      end
    end
  end
end

def threshold
  30.seconds
end

