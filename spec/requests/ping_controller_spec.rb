require 'rails_helper'

RSpec.describe 'Api::PingController' do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let(:id1) { user1.id }
  let(:id2) { user2.id }
  let(:external_id1) { user1.external_id }
  let(:external_id2) { user2.external_id }
  let(:good_auth_token) { 'super secret' }
  let(:payload) { {} }
  let(:auth_token) { good_auth_token }
  let(:headers) {  { "HTTP_AUTHORIZATION" => "Token token=\"#{auth_token}\"" } }

  before do
    ApiToken.create!(token: good_auth_token)
  end

  describe '#create' do
    before do
      post api_ping_path, payload, headers
    end

    describe 'authenticated request' do
      describe 'with an empty payload' do
        it 'returns back a 400' do
          expect(response.status).to eq(400)
        end
      end

      describe 'with a bad payload' do
        let(:payload) { { ids: [] } }

        it 'returns back a 400' do
          expect(response.status).to eq(400)
        end
      end

      describe 'with a payload of undefined users' do
        let(:payload) { { ids: ['monkey'] } }

        it 'returns back a 404' do
          expect(response.status).to eq(404)
        end
      end

      describe 'with good payload' do
        let(:payload) { { ids: [ external_id1, external_id2 ] } }

        it 'returns back a 201' do
          expect(response.status).to eq(201)
        end

        it 'creates a pairing session' do
          expect(PairingSession.count).to eq(1)
        end

        it 'created pairing session should contain both ids' do
          pairing_session = PairingSession.first

          expect(pairing_session.users.pluck :id).to eq([id1, id2])
        end
      end
    end

    describe 'unauthenticated request' do
      let(:headers) { {} }

      it 'returns back a 401' do
        expect(response.status).to eq(401)
      end
    end

    describe 'request with bad credentials' do
      let(:auth_token) { 'monkey' }

      it 'returns back a 401' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'real' do
    it 'created pairing session should contain both ids' do
      payload = { ids: [ external_id1 ] } 

      current_time = Time.now

      Timecop.freeze(current_time - 20.seconds) do
        post api_ping_path, payload, headers
      end

      Timecop.freeze(current_time - 15.seconds) do
        post api_ping_path, payload, headers
      end

      Timecop.freeze(current_time - 10.seconds) do
        post api_ping_path, payload, headers
      end

      Timecop.freeze(current_time - 5.seconds) do
        post api_ping_path, payload, headers
      end

      Timecop.freeze(current_time) do
        post api_ping_path, payload, headers
      end

      pairing_session = PairingSession.first

      expect(pairing_session.users.pluck :id).to eq([id1])
    end

    it 'person walks away and comes back' do
      payload1 = { ids: [ external_id1, external_id2 ] } 
      payload2 = { ids: [ external_id1, external_id1 ] } 

      current_time = Time.now

      Timecop.freeze(current_time - 20.seconds) do
        post api_ping_path, payload1, headers
      end

      Timecop.freeze(current_time - 15.seconds) do
        post api_ping_path, payload1, headers
      end

      Timecop.freeze(current_time - 10.seconds) do
        post api_ping_path, payload2, headers
      end

      Timecop.freeze(current_time - 5.seconds) do
        post api_ping_path, payload2, headers
      end

      Timecop.freeze(current_time) do
        post api_ping_path, payload1, headers
      end

      expect(PairingSession.count).to eq(2)

      expect(PairingSession.first.users.pluck :id).to eq([id1, id2])
      expect(PairingSession.last.users.pluck :id).to eq([id1])
    end
  end
end
