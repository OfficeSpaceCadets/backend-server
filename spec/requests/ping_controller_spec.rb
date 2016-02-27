require 'rails_helper'

RSpec.describe 'PingController' do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let(:id1) { user1.id }
  let(:id2) { user2.id }
  let(:good_auth_token) { 'super secret' }
  let(:payload) { {} }
  let(:auth_token) { good_auth_token }
  let(:headers) {  { "HTTP_AUTHORIZATION" => "Token token=\"#{auth_token}\"" } }

  before do
    ApiToken.create!(token: good_auth_token)
  end

  describe '#create' do
    before do
      post ping_path, payload, headers
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

      describe 'with good payload' do
        let(:payload) { { ids: [ id1, id2 ] } }

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
end
