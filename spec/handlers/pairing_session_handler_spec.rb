require 'rails_helper'

RSpec.describe PairingSessionHandler do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let(:user_ids) { [user1.id, user2.id] }

  subject { described_class.new user_ids }

  describe '#create_or_update_session' do
    context 'no previous session exists' do
      let(:current_time) { 30.days.ago }
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

      it 'should create a session that contains the users' do
        actual_user_ids = PairingSession.first.users.pluck :id
        
        expect(actual_user_ids).to eq(user_ids)
      end

      it 'should create session with a current start time' do
        expect(PairingSession.first.start_time.to_i).to eq(current_time.to_i)
      end

      it 'should create session with a the same end time as the start time' do
        session = PairingSession.first

        expect(session.start_time).to eq(session.end_time)
      end
    end
  end
end
