module Jwt
  class IssueService < ::ApplicationService
    attr_reader :user

    def initialize(user)
      super()
      @user = user
    end

    def call
      access_token, expire_at = JsonWebToken.encode(user.to_payload)
      refresh_token = user.refresh_tokens.create!

      [access_token, refresh_token.token, expire_at]
    end
  end
end
