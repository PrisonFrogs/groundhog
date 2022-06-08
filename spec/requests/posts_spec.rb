# require 'rails_helper'

RSpec.describe 'Api::PostsController', type: :request do
  let(:post) { create(:post) }
  let(:user) { build(:user, email: 'tester@groundhog.com') }

  describe 'GET /posts' do
    it 'returns 200' do
      get '/api/posts'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /posts/:id' do
    it 'returns 403 when not logged in' do
      get "/api/posts/#{post.id}"
      expect(response).to have_http_status(:forbidden)
    end

    it 'return 200 when logged in' do
      headers = {}
      real_user = User.find_or_initialize_by(email: user.email, nickname: user.nickname)
      real_user.update!(password: 'user.password.here')

      headers['Authorization'] = "Bearer #{real_user.to_token}"

      get "/api/posts/#{post.id}", params: nil, headers: headers

      expect(response).to have_http_status(:success)
    end
  end
end
