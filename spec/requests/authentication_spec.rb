# require 'rails_helper'

RSpec.describe 'Api::AuthenticationController', type: :request do
  let(:user) { build(:user, email: 'tester@groundhog.com') }

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

    it 'should be able to refresh access token by an access token' do
      real_user = User.find_or_initialize_by(email: user.email, nickname: user.nickname)
      real_user.update!(password: 'user.password.here')

      _, refresh_token, = real_user.to_token

      post '/api/auth/refresh', params: { refresh_token: }

      expect(response).to have_http_status(200)
    end
  end
end
