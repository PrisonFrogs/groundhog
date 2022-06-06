# require 'rails_helper'

RSpec.describe 'Api::PostsController', type: :request do
  let(:post) { create(:post) }

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
      token = User.first.to_token
      headers['Authorization'] = "Bearer #{token}"

      puts headers['Authorization']

      get "/api/posts/#{post.id}", params: nil, headers: headers

      expect(response).to have_http_status(:success)
    end
  end
end
