require 'rails_helper'

RSpec.describe Api::TodaysSessionsController do
  describe 'GET #index' do
    let!(:user1) { create :user }
    let!(:user2) { create :user }
    let!(:user3) { create :user }
    let!(:session1) { create :pairing_session, start_time: 20.minutes.ago, end_time: 15.minutes.ago, users: [user1, user2] }
    let!(:session2) { create :pairing_session, start_time: 30.minutes.ago, end_time: 20.minutes.ago, users: [user1, user2] }
    let!(:session3) { create :pairing_session, start_time: 24.hours.ago, end_time: 23.hours.ago, users: [user3] }

    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end

    context 'fetching the pairing data' do
      before do
        get :index
      end

      it 'should contain all pairing sessions' do
        pairing_sessions = JSON.parse(response.body)

        expect(pairing_sessions.count).to eq(3)
      end

      context 'two people working together' do
        it 'should transform the pairing sessions' do
          expected_object = { 
            'users' => [ 
              {'external_id' => user1.external_id, 'name' => user1.name}, 
              {'external_id' => user2.external_id, 'name' => user2.name} 
            ],  
            'start_time' => session1.start_time.strftime('%m/%d/%Y %H:%M:%S'),
            'end_time' => session1.end_time.strftime('%m/%d/%Y %H:%M:%S'),
            'duration' => '5 minutes', 
            'pair_clock' => '00:05:00' 
          }

          pairing_sessions = JSON.parse(response.body)

          expect(pairing_sessions.first).to eq(expected_object)
        end
      end

      context 'one person working by themself' do
        it 'should transform the pairing session' do
          expected_object = { 
            'users' => [ 
              {'external_id' => user3.external_id, 'name' => user3.name}
            ],  
            'start_time' => session3.start_time.strftime('%m/%d/%Y %H:%M:%S'),
            'end_time' => session3.end_time.strftime('%m/%d/%Y %H:%M:%S'),
            'duration' => 'about 1 hour', 
            'pair_clock' => '01:00:00' 
          }

          pairing_sessions = JSON.parse(response.body)

          expect(pairing_sessions.last).to eq(expected_object)
        end
      end
    end
  end
end

