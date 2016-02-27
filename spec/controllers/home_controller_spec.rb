require 'rails_helper'

RSpec.describe HomeController do

  describe 'GET #index' do
    let!(:user1) { create :user }
    let!(:user2) { create :user }
    let!(:user3) { create :user }
    let!(:session1) { create :pairing_session }
    let!(:session2) { create :pairing_session }

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

      expect(assigns(:pairing_sessions).count).to eq(2)
    end

    it 'should transform the pairing sessions' do
      get :index

      expected_object = { 
        users: [ user1.name, user2.name ],  
        start_time: session1.start_time.strftime('%m/%d/%Y %H:%M:%S'),
        end_time: session1.end_time.strftime('%m/%d/%Y %H:%M:%S'),
      }

      expect(assigns(:pairing_sessions).first).to eq(expected_object)
    end
  end

end
