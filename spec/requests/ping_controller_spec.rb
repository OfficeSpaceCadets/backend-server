require 'rails_helper'

RSpec.describe 'PingController' do
  let(:id1) { 'id 2' }
  let(:id2) { 'id 1' }
  let(:payload) { { ids: [ id1, id2 ] } }
  let(:good_auth_token) { 'super secret' }
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

      it 'returns back a 201' do
        expect(response.status).to eq(201)
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
