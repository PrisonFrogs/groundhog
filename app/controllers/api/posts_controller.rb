module Api
  class PostsController < ApplicationController
    before_action :require_auth, only: %i[show destroy create]
    before_action :set_post, only: %i[show destroy]

    def index
      @page = params[:page] || 1
      @per_page = params[:per_page] || 10

      @posts = Post.list_on_homepage.page(@page).per(@per_page)
      @total = @posts.total_count

      render_payload(posts: @posts, total: @total)
    end

    def show
      render_payload(post: @post)
    end

    def create; end

    def destroy; end

    private

    def set_post
      @post = Post.find(params[:id])
    end
  end
end
