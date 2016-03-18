require 'rails_helper'

RSpec.describe Api::TodaysSessionsController do
  describe 'GET #index' do
    let!(:user1) { create :user }
    let!(:user2) { create :user }
    let!(:user3) { create :user }
    let!(:session1) { create :pairing_session, start_time: 20.minutes.ago, end_time: 15.minutes.ago }
    let!(:session2) { create :pairing_session, start_time: 30.minutes.ago, end_time: 20.minutes.ago }

    before do
      session1.users = [user1, user2]
      session2.users = [user2, user3]

      session1.save
      session2.save
    end

    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'should contain all pairing sessions' do
      get :index

      pairing_sessions = JSON.parse(response.body)

      expect(pairing_sessions.count).to eq(2)
    end

    it 'should transform the pairing sessions' do
      get :index

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
end

