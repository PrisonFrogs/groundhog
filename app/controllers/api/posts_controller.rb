module Api
  class PostsController < ApplicationController
    include PostsConcern

    before_action :require_auth, only: %i[show destroy create like]
    before_action :set_post, only: %i[show destroy like]

    def index
      @page = params[:page] || 1
      @per_page = params[:per_page] || 10

      @posts = Post.list_on_homepage.page(@page).per(@per_page)
      @total = @posts.total_count

      render_payload(posts: posts_payload(@posts), total: @total)
    end

    def show
      @page = params[:page] || 1
      @per_page = params[:per_page] || 10

      @comments = @post.comments.order(created_at: :desc).page(@page).per(@per_page)
      @comments_count = @comments.total_count

      render_payload(post: posts_payload(@post), comments: posts_payload(@comments), comments_count: @comments_count)
    end

    def create
      @post = current_user.posts.new(post_params)

      @post.save!

      render_payload(post: posts_payload(@post))
    end

    def destroy; end

    def like
      result = @post.liked_by current_user
      render_payload(result:, post: posts_payload(@post))
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :post_id)
    end
  end
end
