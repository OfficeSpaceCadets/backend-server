require 'rails_helper'

describe PairingSessionReporter do
  context '#todays_pairs' do
    context 'no session' do
      it 'should be empty' do
        expect(subject.todays_pairs).to be_empty
      end
    end

    context 'one session of two people' do
      let!(:user1) { create :user }
      let!(:user2) { create :user }
      let!(:pairing_session) { create :pairing_session, users: [user1, user2] }

      it 'should have one session' do
        expect(subject.todays_pairs.count).to eq(1)
      end

      it 'should include both users' do
        external_user_ids = subject.todays_pairs.first[:users].map{|u| u[:external_id]}
        expect(external_user_ids).to eq([user1.external_id, user2.external_id])
      end
    end

    context 'one session of one person' do
      let!(:user1) { create :user }
      let!(:pairing_session) { create :pairing_session, users: [user1] }

      it 'should have one session' do
        expect(subject.todays_pairs.count).to eq(1)
      end

      it 'should include the only user' do
        users_for_session = subject.todays_pairs.first[:users]
        expect(users_for_session.count).to eq(1)
        expect(users_for_session.first[:external_id]).to eq(user1.external_id)
      end
    end
  end
end
