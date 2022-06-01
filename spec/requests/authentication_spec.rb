# require 'rails_helper'

RSpec.describe 'Api::AuthenticationController', type: :request do
  describe 'GET /shake' do
    it 'returns 200 when not login' do
      get '/api/auth/shake'
      payload = JSON.parse(response.body).fetch('payload')
      expect(payload.fetch('nickname')).to eq(nil)
    end

    it 'returns 403 when authorization header is wrong' do
      headers = { 'Authorization' => 'Bearer BAD' }
      get '/api/auth/shake', headers: headers
      expect(response).to have_http_status(403)
    end
  end
end
