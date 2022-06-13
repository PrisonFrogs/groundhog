module Api
  module PostsConcern
    def posts_payload(posts)
      if posts.respond_to?(:map)
        posts.map do |post|
          post.as_payload(current_user)
        end
      else
        posts.as_payload(current_user)
      end
    end
  end
end
