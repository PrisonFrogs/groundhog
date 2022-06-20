module PostsListConcern
  extend ActiveSupport::Concern

  included do
    scope :list_on_homepage, lambda {
                               where('created_at > ?', Post.last.created_at - 3.days)
                                 .where.not(title: nil)
                                 .order(updated_at: :desc)
                             }

    def as_payload(user = nil)
      {
        id:,
        title:,
        content:,
        author_nickname:,
        likes_count:,
        liked_by_current_user: user ? liked_by?(user) : false
      }
    end
  end
end
